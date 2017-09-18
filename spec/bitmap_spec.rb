require './lib/bitmap.rb'

describe Bitmap do
  context 'creating a new Bitmap' do
    it 'raises error if width is less than 1' do
      expect { Bitmap.new(0,22) }.to raise_error(StandardError, "Out of bounds")
    end

    it 'raises error if width is greater than 250' do
      expect { Bitmap.new(251,22) }.to raise_error(StandardError, "Out of bounds")
    end

    it 'raises error if height is less than 1' do
      expect { Bitmap.new(22,0) }.to raise_error(StandardError, "Out of bounds")
    end

    it 'raises error if height is greater than 250' do
      expect { Bitmap.new(22,251) }.to raise_error(StandardError, "Out of bounds")
    end
  end

  context 'colouring a pixel' do
    let(:bitmap) { Bitmap.new(5,5) }
    it 'raises error if pixel is out of bounds' do
      expect { bitmap.set_pixel_colour(7, 8, 'O') }.to raise_error(StandardError,
        "Pixel 7, 8 doesn't exist in bitmap")
    end
  end
end
