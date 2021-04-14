require_relative 'file_reader'
require 'colorize'
require 'strscan'

class CheckOffenses
  attr_reader :detector, :mistakes

  def initialize(path)
    @detector = FileReader.new(path)
    @mistakes = []
    @reserved_words = %w[begin case class def do if module unless]
  end

  def trailing_spaces
    @detector.lines.each_with_index do |str_val, pos|
      if str_val[-2] == ' ' && !str_val.strip.empty?
        @mistakes << "line:#{pos + 1}:#{str_val.size - 1}: Error: Trailing whitespace."
        + " '#{str_val.gsub(/\s*$/, '_')}'"
      end
    end
  end

  def tag_error
    detect_tag_error(/\(/, /\)/, '(', ')', 'Parenthesis.')
    detect_tag_error(/\[/, /\]/, '[', ']', 'Bracket.')
    detect_tag_error(/\{/, /\}/, '{', '}', 'Curly Bracket.')
  end

  def end_error
    kw_counter = 0
    end_counter = 0
    @detector.lines.each_with_index do |str_val, _pos|
      kw_counter += 1 if @reserved_words.include?(str_val.split.first) || str_val.split.include?('do')
      end_counter += 1 if str_val.strip == 'end'
    end

    err_type = kw_counter <=> end_counter
    log_error("Lint/Syntax: Missing 'end'.") if err_type.eql?(1)
    log_error("Lint/Syntax: Unexpected 'end'.") if err_type.eql?(-1)
  end

  def empty_line
    @detector.lines.each_with_index do |str_val, indx|
      check_class_empty_line(str_val, indx)
      check_def_empty_line(str_val, indx)
      check_end_empty_line(str_val, indx)
      check_do_empty_line(str_val, indx)
    end
  end

  # rubocop: disable Metrics/CyclomaticComplexity

  def indentation
    msg = 'IndentationWidth: Use 2 spaces for indentation.'
    current_val = 0
    indent_val = 0

    @detector.lines.each_with_index do |str_val, indx|
      strip_line = str_val.strip.split
      exp_val = current_val * 2
      res_word = %w[class def if elsif until module unless begin case]

      next unless !str_val.strip.empty? || !strip_line.first.eql?('#')

      indent_val += 1 if res_word.include?(strip_line.first) || strip_line.include?('do')
      indent_val -= 1 if str_val.strip == 'end'

      next if str_val.strip.empty?

      indent_error(str_val, indx, exp_val, msg)
      current_val = indent_val
    end
  end

  private

  def indent_error(str_val, pos, exp_val, msg)
    strip_line = str_val.strip.split
    emp = str_val.match(/^\s*\s*/)
    end_chk = emp[0].size.eql?(exp_val.zero? ? 0 : exp_val - 2)

    if str_val.strip.eql?('end') || strip_line.first == 'elsif' || strip_line.first == 'when'
      log_error("line:#{pos + 1} #{msg}") unless end_chk
    elsif !emp[0].size.eql?(exp_val)
      log_error("line:#{pos + 1} #{msg}")
    end
  end

  # rubocop: enable Metrics/CyclomaticComplexity

  def detect_tag_error(*args)
    @detector.lines.each_with_index do |str_val, index|
      open_p = []
      close_p = []
      open_p << str_val.scan(args[0])
      close_p << str_val.scan(args[1])

      err_type = open_p.flatten.size <=> close_p.flatten.size

      log_error("line:#{index + 1} Lint/Syntax: Unexpected/Missing token '#{args[2]}' #{args[4]}") if err_type.eql?(1)
      log_error("line:#{index + 1} Lint/Syntax: Unexpected/Missing token '#{args[3]}' #{args[4]}") if err_type.eql?(-1)
    end
  end

  def check_class_empty_line(str_val, indx)
    msg = 'Extra empty line detected at class.'
    return unless str_val.strip.split.first.eql?('class')

    log_error("line:#{indx + 2} #{msg}") if @detector.lines[indx + 1].strip.empty?
  end

  def check_def_empty_line(str_val, indx)
    msg1 = 'Extra empty line detected at method.'
    msg2 = 'Use empty lines between method definition.'

    return unless str_val.strip.split.first.eql?('def')

    log_error("line:#{indx + 2} #{msg1}") if @detector.lines[indx + 1].strip.empty?
    log_error("line:#{indx + 1} #{msg2}") if @detector.lines[indx - 1].strip.split.first.eql?('end')
  end

  def check_end_empty_line(str_val, indx)
    return unless str_val.strip.split.first.eql?('end')

    log_error("line:#{indx} Empty line detected at block end.") if @detector.lines[indx - 1].strip.empty?
  end

  def check_do_empty_line(str_val, indx)
    msg = 'Extra empty line detected at block.'
    return unless str_val.strip.split.include?('do')

    log_error("line:#{indx + 2} #{msg}") if @detector.lines[indx + 1].strip.empty?
  end

  def log_error(error_msg)
    @mistakes << error_msg
  end
end
