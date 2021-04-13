require 'colorize'

class FileReader
  attr_reader :message, :lines, :path, :lines_size
  def initialize(path)
    @message = ''
    @path = path
    begin
      @lines = File.readlines(@path)
      @lines_size = @lines.size
    rescue StandardError => e
      @lines = []
      @message = "Missing or inexistant file path\n".colorize(:yellow) + e.to_s.colorize(:red)
    end
  end
end
