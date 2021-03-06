require './lib/bitmap_editor.rb'

describe BitmapEditor do
  before(:example) do 
    @bitmap_editor = BitmapEditor.new
  end

  context 'when no bitmap has been created' do
    it 'raises error when running the L command' do
      expect { @bitmap_editor.execute(['L', '1', '2', 'O']) }.to raise_error(StandardError, 'No bitmap found')
    end

    it 'raises error when running the S command' do
      expect { @bitmap_editor.execute(['S']) }.to raise_error(StandardError, 'No bitmap found')
    end

    it 'raises error when running the C command' do
      expect { @bitmap_editor.execute(['C']) }.to raise_error(StandardError, 'No bitmap found')
    end

    it 'raises error when running the V command' do
      expect { @bitmap_editor.execute(['V', '1', '2', '3', 'O']) }.to raise_error(StandardError, 'No bitmap found')
    end

    it 'raises error when running the H command' do
      expect { @bitmap_editor.execute(['H', '1', '2', '3', 'O']) }.to raise_error(StandardError, 'No bitmap found')
    end
  end

  describe 'Unrecognised command' do
    it 'raises Unrecognised command error' do
      expect { @bitmap_editor.execute(['X'])  }.to raise_error(StandardError, 'Unrecognised command: X')
    end
  end

  describe 'I' do
    context 'when given two integers as arguments' do
      let(:output) { `bin/bitmap_editor ./examples/create_bitmap.txt` }

      it 'creates an M x N bitmap with colour white (O)' do
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

  describe 'V' do
    context 'when given 4 arguments X, Y1, Y2 and C' do
      let(:output) { `bin/bitmap_editor ./examples/colour_vertical_segment.txt` }

      it 'draws a vertical segment of colour C in column X between rows Y1 and Y2' do
        expect(output).to eq(<<~EOS
                                OOOOO
                                OOOOO
                                OWOOO
                                OWOOO
                                OWOOO
                                OWOOO
                              EOS
                              )
      end
    end
  end

  describe 'H' do
    context 'when given 4 arguments X1, X2, Y and C' do
      let(:output) { `bin/bitmap_editor ./examples/colour_horizontal_segment.txt` }

      it 'draws a horizontal segment of colour C in col Y between columns X1 and X2' do
        expect(output).to eq(<<~EOS
                                OOOOO
                                OOZZZ
                                OOOOO
                                OOOOO
                                OOOOO
                                OOOOO
                              EOS
                              )
      end
    end
  end

  describe 'C' do
    let(:output) { `bin/bitmap_editor ./examples/clear_bitmap.txt` }

    it 'clears the bitmap, setting all pixels to white (O)' do
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

  describe 'sequence of commands' do
    context 'when given a sequence of commands' do
      let(:output) { `bin/bitmap_editor ./examples/all_commands.txt` }

      it 'creates a bitmap with expected colours' do
        expect(output).to eq(<<~EOS
                                OOOOO
                                OOZZZ
                                AWOOO
                                OWOOO
                                OWOOO
                                OWOOO
                              EOS
                              )
      end
    end

    context 'magic fill' do
      let(:output) { `bin/bitmap_editor ./examples/magic_fill.txt` }

      it 'creates a bitmap with expected colours' do
        expect(output).to eq(<<~EOS
                                MXO
                                MXO
                                MXO
                              EOS
                              )
      end
    end

  end

end
