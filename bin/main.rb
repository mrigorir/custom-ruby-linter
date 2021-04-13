require_relative '../lib/offense_detector'

detect = CheckOffenses.new('../tester.rb')
detect.indentation
detect.trailing_spaces
detect.tag_error
detect.end_error
detect.empty_line

if detect.mistakes.empty? && detect.detector.message.empty?
  puts "#{'No offenses'.colorize(:green)} detected. Impecable!"
else
  detect.mistakes.uniq.each do |err|
    puts "#{detect.detector.path.colorize(:blue)} : #{err.colorize(:red)}"
  end
end

puts detect.detector.message if detect.detector.lines.empty?
