class BitmapEditor
  def run(file)
    return puts 'please provide correct file' if file.nil? || !File.exists?(file)
    image = 'There is no image'
    File.open(file).each do |line|
      line = line.chomp.split(" ")
      command = line[0]
      args = line[1..-1]
      case command
      when 'I'
        image = create_image(args)
      when 'L'
        image = colour_pixel(image, args)
      when 'V'
        image = colour_vertical_segment(image, args)
      when 'H'
        image = colour_horizontal_segment(image, args)
      when 'S'
        image = convert_image_matrix_to_string(image)
      else
        image = 'unrecognised command :('
      end
    end
    puts image
  end

  def create_image(args)
    m = args[0].to_i
    n = args[1].to_i
    Array.new(n){Array.new(m,'O')}
  end

  def colour_pixel(image, args)
    return unless image.is_a? Array
    x = args[0].to_i - 1
    y = args[1].to_i - 1
    colour = args[2]
    image[y][x] = colour
    image
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

  def colour_vertical_segment(image, args)
    return unless image.is_a? Array
    x = args[0].to_i - 1
    y1 = args[1].to_i - 1
    y2 = args[2].to_i - 1
    colour = args[3]
    image[y1..y2].map{ |row| row[x] = colour }
    image
  end

  def convert_image_matrix_to_string(image)
    return unless image.is_a? Array
    image.map{|row| row.join }.join("\n")
  end
end
