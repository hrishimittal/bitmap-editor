require './lib/bitmap_editor.rb'

describe 'I' do
  context 'when given two integers as arguments' do
    let(:output) { `bin/bitmap_editor ./examples/create_image.txt` }
    it 'creates an M x N image with colour white (O)' do
      expect(output).to eq('OOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO')
    end
  end
end
