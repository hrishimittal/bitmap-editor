class BitmapEditor
  def run(file)
    return puts 'please provide correct file' if file.nil? || !File.exists?(file)
    output = ''
    File.open(file).each do |line|
      line = line.chomp.split(" ")
      case line[0]
      when 'I'
        m = line[1].to_i
        n = line[2].to_i
        output = create_image(m, n, output)
      when 'S'
        output = 'There is no image' if output.empty?
      else
        output = 'unrecognised command :('
      end
    end
    puts output
  end

  def create_image(m, n, output)
    b = Array.new(n){Array.new(m,'O')}
    output += b.map{|r| r.join }.join("\n")
    output
  end
end
