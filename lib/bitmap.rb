class Bitmap
  attr_accessor :pixels

  def initialize(width, height)
    @width = width
    @height = height
    @pixels = create_pixels(width, height)
  end

  def create_pixels(width, height)
    fail StandardError, "Out of bounds" if (out_of_bounds?(width) || out_of_bounds?(height))
    Array.new(height){Array.new(width,'O')}
  end

  def format_pixels
    @pixels.map{|row| row.join }.join("\n")
  end

  def clear
    @pixels.map{ |row| row.fill('O') }
  end

  def set_pixel_colour(x, y, colour)
    @pixels[y][x] = colour
  end

  private

  def out_of_bounds?(dimension)
    dimension < 1 || dimension > 250
  end
end
