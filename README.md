# Bitmap editor

A Ruby program that simulates a basic interactive bitmap editor. Bitmaps are represented as an M x N matrix of pixels with each element representing a colour.

There are 7 supported commands:

**I M N** - Create a new M x N image with all pixels coloured white (O).

**C** - Clears the table, setting all pixels to white (O).

**L X Y C** - Colours the pixel (X,Y) with colour C.

**V X Y1 Y2 C** - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).

**H X1 X2 Y C** - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).

**F X Y C** - Magic fill - colours a given pixel and all same-coloured pixels near it until it reaches a pixel with a different colour.

**S** - Show the contents of the current image

## Running

`$ ./bin/bitmap_editor examples/show.txt`

## Testing

Use rspec to run tests:

`$ rspec`
