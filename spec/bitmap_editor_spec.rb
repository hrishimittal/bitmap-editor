require './lib/bitmap_editor.rb'

describe 'I' do
  context 'when given two integers as arguments' do
    let(:output) { `bin/bitmap_editor ./examples/create_image.txt` }

    it 'creates an M x N image with colour white (O)' do
      expect(output).to eq(<<~EOS
                              OOOOO
                              OOOOO
                              OOOOO
                              OOOOO
                              OOOOO
                              OOOOO
                            EOS
                            )
    end
  end
end

describe 'L' do
  context 'when given 3 arguments X, Y and C' do
    let(:output) { `bin/bitmap_editor ./examples/colour_pixel.txt` }

    it 'colours the pixel (X,Y) with colour C' do
      expect(output).to eq(<<~EOS
                              OOOOO
                              OOOOO
                              AOOOO
                              OOOOO
                              OOOOO
                              OOOOO
                            EOS
                            )
    end
  end
end
