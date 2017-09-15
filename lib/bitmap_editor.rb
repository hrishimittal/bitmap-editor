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

  def convert_image_matrix_to_string(image)
    return unless image.is_a? Array
    image.map{|r| r.join }.join("\n")
  end
end
