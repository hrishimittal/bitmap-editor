require './lib/bitmap.rb'

describe Bitmap do
  context 'creating a new Bitmap' do
    it 'raises error if width is less than 1' do
      expect do
        Bitmap.new('0', '22')
      end.to raise_error(StandardError, 'Bitmap dimensions out of bounds')
    end

    it 'raises error if width is greater than 250' do
      expect do
        Bitmap.new('251', '22')
      end.to raise_error(StandardError, 'Bitmap dimensions out of bounds')
    end

    it 'raises error if height is less than 1' do
      expect do
        Bitmap.new('22', '0')
      end.to raise_error(StandardError, 'Bitmap dimensions out of bounds')
    end

    it 'raises error if height is greater than 250' do
      expect do
        Bitmap.new('22', '251')
      end.to raise_error(StandardError, 'Bitmap dimensions out of bounds')
    end
  end

  context 'colouring a pixel' do
    let(:bitmap) { Bitmap.new('5', '5') }
    it 'raises error if pixel is out of bounds' do
      expect do
        bitmap.set_pixel_colour('7', '8', 'O')
      end.to raise_error(StandardError, 'Pixel 7, 8 doesn\'t exist in bitmap')
    end
  end

  context 'colouring a horizontal segment' do
    let(:bitmap) { Bitmap.new('5', '5') }
    it 'raises error if horizontal segment is out of bounds' do
      expect do
        bitmap.set_horizontal_segment_colour('2', '3', '8', 'O')
      end.to raise_error(StandardError, 'Segment out of bounds')
    end
  end

  context 'colouring a vertical segment' do
    let(:bitmap) { Bitmap.new('5', '5') }
    it 'raises error if vertical segment is out of bounds' do
      expect do
        bitmap.set_vertical_segment_colour('0', '6', '8', 'O')
      end.to raise_error(StandardError, 'Segment out of bounds')
    end
  end
end
