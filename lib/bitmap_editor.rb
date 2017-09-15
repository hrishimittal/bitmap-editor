class BitmapEditor
  def run(file)
    return puts 'please provide correct file' if file.nil? || !File.exists?(file)
    image = 'There is no image'
    File.open(file).each do |line|
      line = line.chomp.split(" ")
      case line[0]
      when 'I'
        m = line[1].to_i
        n = line[2].to_i
        image = create_image(m, n)
      when 'L'
        x = line[1].to_i - 1
        y = line[2].to_i - 1
        colour = line[3]
        image = colour_pixel(x, y, colour, image)
      when 'V'
        x = line[1].to_i - 1
        y1 = line[2].to_i - 1
        y2 = line[3].to_i - 1
        colour = line[4]
        image = colour_vertical_segment(x, y1, y2, colour, image)
      when 'H'
        x1 = line[1].to_i - 1
        x2 = line[2].to_i - 1
        y = line[3].to_i - 1
        colour = line[4]
        colour_horizontal_segment(x1, x2, y, colour, image)
      when 'S'
        image = convert_image_matrix_to_string(image)
      else
        image = 'unrecognised command :('
      end
    end
    puts image
  end

  def create_image(m, n)
    Array.new(n){Array.new(m,'O')}
  end

  def colour_pixel(x, y, colour, image)
    image[y][x] = colour
    image
  end

  def colour_horizontal_segment(x1, x2, y, colour, image)
    return unless image.is_a? Array
    image[y].fill(colour, x1..x2)
    image
  end

  def colour_vertical_segment(x, y1, y2, colour, image)
    return unless image.is_a? Array
    image[y1..y2].map{ |row| row[x] = colour }
    image
  end

  def convert_image_matrix_to_string(image)
    return unless image.is_a? Array
    image.map{|row| row.join }.join("\n")
  end
end
