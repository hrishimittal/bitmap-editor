require './lib/bitmap.rb'

describe Bitmap do
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
