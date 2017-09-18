class Bitmap
  def initialize(width, height)
    @width = width
    @height = height
    @pixels = create_pixels(width, height)
  end

  def create_pixels(width, height)
    raise StandardError, 'Out of bounds' if out_of_bounds?(width) ||
                                            out_of_bounds?(height)
    Array.new(height) { Array.new(width, 'O') }
  end

  def format_pixels
    @pixels.map(&:join).join("\n")
  end

  def clear
    @pixels.map { |row| row.fill('O') }
  end

  def set_horizontal_segment_colour(x1, x2, y, colour)
    if out_of_bounds?(x1, @width) || out_of_bounds?(x2, @width) ||
       out_of_bounds?(y, @height)
      raise StandardError, 'Segment out of bounds'
    end
    @pixels[y - 1].fill(colour, (x1 - 1)..(x2 - 1))
  end

  def set_vertical_segment_colour(x, y1, y2, colour)
    if out_of_bounds?(x, @width) || out_of_bounds?(y2, @height) ||
       out_of_bounds?(y2, @height)
      raise StandardError, 'Segment out of bounds'
    end
    @pixels[(y1 - 1)..(y2 - 1)].map { |row| row[x - 1] = colour }
  end

  def set_pixel_colour(x, y, colour)
    if out_of_bounds?(x, @width) || out_of_bounds?(y, @height)
      raise StandardError, "Pixel #{x}, #{y} doesn't exist in bitmap"
    end
    @pixels[y - 1][x - 1] = colour
  end

  private

  def out_of_bounds?(dimension, max = 250)
    dimension < 1 || dimension > max
  end
end
