class Bitmap
  attr_accessor :pixels

  def initialize(width, height)
    @width = width
    @height = height
    @pixels = Array.new(height){Array.new(width,'O')}
  end

  def format_pixels
    @pixels.map{|row| row.join }.join("\n")
  end

  def clear
    @pixels.map{ |row| row.fill('O') }
  end
end
