import 'dart:convert';
import 'dart:ffi';
import 'package:ffi/ffi.dart';

Pointer<Char> stringToPointer(String str) {

  final utf8Bytes = utf8.encode(str);
  final buffer = calloc.allocate<Int8>(utf8Bytes.length + 1); // +1 for null terminator

  buffer.asTypedList(utf8Bytes.length).setAll(0, utf8Bytes);
  buffer[utf8Bytes.length] = 0; // Null terminator

  return buffer.cast<Char>();
}

String pointerToString(Pointer<Char> charPointer) {

  final ptr = charPointer.cast<Utf8>();

  return ptr.toDartString();
}