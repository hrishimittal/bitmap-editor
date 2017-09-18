require './lib/bitmap.rb'

class BitmapEditor
  attr_accessor :bitmap

  def initialize
    @bitmap = nil
  end

  def run(filename)
    commands = parse_commands(filename)
    commands.each { |command| execute(command.split) }
  rescue StandardError => e
    $stderr.puts e.message
  end

  def execute(command_with_args)
    command = command_with_args.shift
    args = command_with_args

    case command
    when 'I'
      create_image(args)
    when 'L'
      colour_pixel(args)
    when 'V'
      colour_vertical_segment(args)
    when 'H'
      colour_horizontal_segment(args)
    when 'C'
      @bitmap.clear
    when 'S'
      print_bitmap
    else
      fail StandardError, "Unrecognised command: #{command}"
    end
  end

  def parse_commands(filename)
    fail StandardError, "Please provide a command file." if filename.nil?
    fail StandardError, "Command file doesn't exist. Please provide a correct command file." if !File.exists?(filename)
    IO.readlines(filename).map(&:chomp)
  end

  def create_image(args)
    width = args[0].to_i
    height = args[1].to_i
    @bitmap = Bitmap.new(width, height)
  end

  def colour_pixel(args)
    check_if_bitmap_exists
    x = args[0].to_i
    y = args[1].to_i
    colour = args[2]
    @bitmap.set_pixel_colour(x, y, colour)
  end

  def colour_horizontal_segment(args)
    x1 = args[0].to_i
    x2 = args[1].to_i
    y = args[2].to_i
    colour = args[3]
    @bitmap.set_horizontal_segment_colour(x1, x2, y, colour)
  end

  def colour_vertical_segment(args)
    x = args[0].to_i
    y1 = args[1].to_i
    y2 = args[2].to_i
    colour = args[3]
    @bitmap.set_vertical_segment_colour(x, y1, y2, colour)
  end

  def check_if_bitmap_exists
    fail StandardError, "No bitmap found" if @bitmap.nil?
  end

  def print_bitmap
    puts @bitmap.format_pixels
  end
end
