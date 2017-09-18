class Bitmap
  attr_accessor :pixels

  def initialize(width, height)
    @width = width
    @height = height
    @pixels = Array.new(height){Array.new(width,'O')}
  end
end
