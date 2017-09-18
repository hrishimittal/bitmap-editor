require './lib/bitmap.rb'

class BitmapEditor
  attr_accessor :bitmap

  def initialize
    @bitmap = nil
  end

  def run(filename)
    commands = parse_commands(filename)
    commands.each { |command| execute(command.split) }
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
      image = colour_horizontal_segment(image, args)
    when 'C'
      image = clear_image(image)
    when 'S'
      print_bitmap
    else
      image = 'unrecognised command :('
    end
  end

  def parse_commands(filename)
    raise 'please provide correct file' if filename.nil? || !File.exists?(filename)
    IO.readlines(filename).map(&:chomp)
  rescue RuntimeError => e
    $stderr.puts e.message
  end

  def create_image(args)
    width = args[0].to_i
    height = args[1].to_i
    @bitmap = Bitmap.new(width, height)
  end

  def colour_pixel(args)
    x = args[0].to_i - 1
    y = args[1].to_i - 1
    colour = args[2]
    @bitmap.pixels[y][x] = colour
  end

  def colour_horizontal_segment(image, args)
    return unless image.is_a? Array
    x1 = args[0].to_i - 1
    x2 = args[1].to_i - 1
    y = args[2].to_i - 1
    colour = args[3]
    image[y].fill(colour, x1..x2)
    image
  end

  def colour_vertical_segment(args)
    x = args[0].to_i - 1
    y1 = args[1].to_i - 1
    y2 = args[2].to_i - 1
    colour = args[3]
    @bitmap.pixels[y1..y2].map{ |row| row[x] = colour }
  end

  def clear_image(image)
    return unless image.is_a? Array
    image.map{ |row| row.fill('O') }
  end

  def print_bitmap
    puts @bitmap.format_pixels
  end
end
