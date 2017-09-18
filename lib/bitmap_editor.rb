require './lib/bitmap.rb'

class BitmapEditor
  attr_accessor :bitmap

  def initialize
    @bitmap = nil
    @commands = {
      I: proc { |args| create_bitmap(args) },
      L: proc { |args| colour_pixel(args) },
      V: proc { |args| colour_vertical_segment(args) },
      H: proc { |args| colour_horizontal_segment(args) },
      C: proc { clear_bitmap },
      S: proc { print_bitmap }
    }
  end

  def run(filename)
    commands = parse_commands(filename)
    commands.each { |command| execute(command.split) }
  rescue StandardError => e
    $stderr.puts e.message
  end

  def execute(command_with_args)
    command = command_with_args.shift.to_sym
    args = command_with_args
    unless @commands.keys.include? command
      raise StandardError, "Unrecognised command: #{command}"
    end
    @commands[command].call(args)
  end

  def parse_commands(filename)
    raise StandardError, 'Please provide a command file.' if filename.nil?
    unless File.exist?(filename)
      raise StandardError,
            'File doesn\'t exist. Please provide a correct command file.'
    end

    # Note on performance: Reading in the whole file at once may be slow
    # for large files and should be optimised accordingly
    IO.readlines(filename).map(&:chomp)
  end

  def create_bitmap(args)
    width, height = args
    @bitmap = Bitmap.new(width, height)
  end

  def colour_pixel(args)
    check_if_bitmap_exists
    x, y, colour = args
    @bitmap.set_pixel_colour(x, y, colour)
  end

  def colour_horizontal_segment(args)
    check_if_bitmap_exists
    x1, x2, y, colour = args
    @bitmap.set_horizontal_segment_colour(x1, x2, y, colour)
  end

  def colour_vertical_segment(args)
    check_if_bitmap_exists
    x, y1, y2, colour = args
    @bitmap.set_vertical_segment_colour(x, y1, y2, colour)
  end

  def clear_bitmap
    check_if_bitmap_exists
    @bitmap.clear
  end

  def check_if_bitmap_exists
    raise StandardError, 'No bitmap found' if @bitmap.nil?
  end

  def print_bitmap
    check_if_bitmap_exists
    puts @bitmap.format_pixels
  end
end
