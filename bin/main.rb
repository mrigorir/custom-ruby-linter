require_relative '../lib/offense_detector'

p detect = CheckOffenses.new('../tester.rb')
p detect.indentation
p detect.trailing_spaces
p detect.tag_error
p detect.end_error
p detect.empty_line

if detect.mistakes.empty? && detect.detector.message.empty?
  puts "#{'No offenses'.colorize(:green)} detected. Impecable!"
else
  detect.mistakes.uniq.each do |err|
    puts "#{detect.detector.path.colorize(:blue)} : #{err.colorize(:red)}"
  end
end

puts detect.detector.message if detect.detector.lines.empty?
