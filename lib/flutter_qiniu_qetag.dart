library flutter_qiniu_qetag;

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'dart:typed_data';

import 'package:crypto/crypto.dart';


const int CHUNK_BITS = 22;
const int CHUNK_SIZE = 1 << CHUNK_BITS;

getIoQetag(Uint8List fio) {
  var size = fio.length;
  var flag = CHUNK_BITS;
  List<List<int>> buf = [];
  for (var i = 0; i < size; i += CHUNK_SIZE) {
    var digest = sha1.convert(fio.sublist(i, min(size, i + CHUNK_SIZE)));
    buf.add(digest.bytes);
  }
  var bufBytes = buf.reduce((prev, current) => prev + current);
  if (bufBytes.length > 20) {
    flag |= 0x80;
    bufBytes = sha1.convert(bufBytes).bytes;
  }
  return base64Url.encode([flag] + bufBytes);
}

getQetag(String path) {
  var file = File(path);
  var content = file.readAsBytesSync();
  return getIoQetag(content);
}

main() {
  print(getQetag('lib/flutter_qiniu_qetag.dart'));
}
