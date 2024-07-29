import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:onnx_genai/generated_bindings.dart';
import 'package:onnx_genai/utils.dart';

class TokenizerStream {
  final Pointer<OgaModel> handle;
  final Pointer<OgaTokenizerStream> tokenizerHandle;
  final onnx_genai model;

  TokenizerStream(this.handle, this.model, this.tokenizerHandle);

  factory TokenizerStream.create(onnx_genai model, Pointer<OgaModel> modelHandle, Pointer<OgaTokenizer> tokenizerHandle) {
    Pointer<Pointer<OgaTokenizerStream>> out = calloc.allocate(sizeOf<Pointer<Pointer<OgaTokenizerStream>>>());

    model.OgaCreateTokenizerStream(tokenizerHandle, out);

    return TokenizerStream(modelHandle, model, out.value);
  }

  String decode(int token) {
   
    Pointer<Pointer<Char>> out = calloc.allocate(sizeOf<Pointer<Pointer<Char>>>());

    model.OgaTokenizerStreamDecode(tokenizerHandle, token, out);

    return pointerToString(out.value);

  }

  // TODO: Add in methods
}
