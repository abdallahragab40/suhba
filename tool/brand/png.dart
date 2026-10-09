import 'dart:io';
import 'dart:typed_data';

/// Encodes straight (non-premultiplied) RGBA pixels as PNG. With
/// [alpha] false the alpha channel is dropped, which App Store icons
/// require.
Uint8List encodePng(
  Uint8List rgba,
  int width,
  int height, {
  bool alpha = true,
}) {
  final channels = alpha ? 4 : 3;
  final raw = BytesBuilder(copy: false);
  for (var y = 0; y < height; y++) {
    raw.addByte(0); // filter: none
    final row = Uint8List(width * channels);
    for (var x = 0; x < width; x++) {
      final from = (y * width + x) * 4;
      final to = x * channels;
      row
        ..[to] = rgba[from]
        ..[to + 1] = rgba[from + 1]
        ..[to + 2] = rgba[from + 2];
      if (alpha) row[to + 3] = rgba[from + 3];
    }
    raw.add(row);
  }

  final header = ByteData(13)
    ..setUint32(0, width)
    ..setUint32(4, height)
    ..setUint8(8, 8) // bit depth
    ..setUint8(9, alpha ? 6 : 2) // colour type: RGBA or RGB
    ..setUint8(10, 0)
    ..setUint8(11, 0)
    ..setUint8(12, 0);

  return (BytesBuilder(copy: false)
        ..add(const [137, 80, 78, 71, 13, 10, 26, 10])
        ..add(_chunk('IHDR', header.buffer.asUint8List()))
        ..add(_chunk('IDAT', ZLibEncoder(level: 9).convert(raw.takeBytes())))
        ..add(_chunk('IEND', Uint8List(0))))
      .takeBytes();
}

Uint8List _chunk(String type, List<int> data) {
  final typeBytes = type.codeUnits;
  final out = ByteData(12 + data.length)..setUint32(0, data.length);
  final bytes = out.buffer.asUint8List()
    ..setRange(4, 8, typeBytes)
    ..setRange(8, 8 + data.length, data);
  out.setUint32(8 + data.length, _crc32(bytes, 4, 8 + data.length));
  return bytes;
}

final _crcTable = List<int>.generate(256, (n) {
  var c = n;
  for (var k = 0; k < 8; k++) {
    c = (c & 1) != 0 ? 0xEDB88320 ^ (c >>> 1) : c >>> 1;
  }
  return c;
});

int _crc32(Uint8List bytes, int start, int end) {
  var crc = 0xFFFFFFFF;
  for (var i = start; i < end; i++) {
    crc = _crcTable[(crc ^ bytes[i]) & 0xFF] ^ (crc >>> 8);
  }
  return crc ^ 0xFFFFFFFF;
}
