class Bitmap
  def initialize(width, height)
    @width = width.to_i
    @height = height.to_i
    @pixels = create_pixels(@width, @height)
  end

  def create_pixels(width, height)
    if out_of_bounds?(width) || out_of_bounds?(height)
      raise StandardError, 'Bitmap dimensions out of bounds'
    end
    Array.new(height) { Array.new(width, 'O') }
  end

  def format_pixels
    @pixels.map(&:join).join("\n")
  end

  def clear
    @pixels.map { |row| row.fill('O') }
  end

  def magic_fill(x, y, colour)
    x = x.to_i
    y = y.to_i
    if out_of_bounds?(x, @width) || out_of_bounds?(y, @height)
      raise StandardError, 'Pixel out of bounds'
    end
    current_colour = get_pixel_colour(x, y)
    pixels_to_fill = [[x, y]]

    while pixel = pixels_to_fill.shift
      set_pixel_colour(*pixel, colour)
      pixels_to_fill += find_pixels_to_colour(*pixel, current_colour)
      pixels_to_fill.uniq!
    end
  end

  def find_pixels_to_colour(x, y, current_colour)
    pixels_to_fill = []
    adjacent_pixels = get_adjacent_pixels_for_pixel(x, y)
    pixels = adjacent_pixels.map do |pixel|
      pixels_to_fill << pixel if is_in_magic_area?(*pixel, current_colour)
    end
    pixels_to_fill
  end

  def get_adjacent_pixels_for_pixel(x, y)
    [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]]
  end

  def is_in_magic_area?(x, y, current_colour)
    if !out_of_bounds?(x, @width) && !out_of_bounds?(y, @height)
      get_pixel_colour(x, y) == current_colour
    end
  end

  def set_horizontal_segment_colour(x1, x2, y, colour)
    x1 = x1.to_i
    x2 = x2.to_i
    y = y.to_i
    if out_of_bounds?(x1, @width) || out_of_bounds?(x2, @width) ||
       out_of_bounds?(y, @height)
      raise StandardError, 'Segment out of bounds'
    end
    @pixels[y - 1].fill(colour, (x1 - 1)..(x2 - 1))
  end

  def set_vertical_segment_colour(x, y1, y2, colour)
    x = x.to_i
    y1 = y1.to_i
    y2 = y2.to_i
    if out_of_bounds?(x, @width) || out_of_bounds?(y2, @height) ||
       out_of_bounds?(y2, @height)
      raise StandardError, 'Segment out of bounds'
    end
    @pixels[(y1 - 1)..(y2 - 1)].map { |row| row[x - 1] = colour }
  end

  def get_pixel_colour(x, y)
    # TODO Check bounds
    @pixels[y - 1][x - 1]
  end

  def set_pixel_colour(x, y, colour)
    x = x.to_i
    y = y.to_i
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
