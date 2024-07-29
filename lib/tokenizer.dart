import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:onnx_genai/generated_bindings.dart';
import 'package:onnx_genai/sequences.dart';
import 'package:onnx_genai/tokenizer_stream.dart';
import 'package:onnx_genai/utils.dart';

class Tokenizer {
  final Pointer<OgaModel> handle;
  final Pointer<OgaTokenizer> tokenizerHandle;
  final onnx_genai model;

  Tokenizer(this.handle, this.model, this.tokenizerHandle);

  factory Tokenizer.create(onnx_genai model, Pointer<OgaModel> modelHandle) {
    Pointer<Pointer<OgaTokenizer>> out = calloc.allocate(sizeOf<Pointer<Pointer<OgaTokenizer>>>());
    model.OgaCreateTokenizer(modelHandle, out);

    return Tokenizer(modelHandle, model, out.value);
  }

  Sequences encode(String str) {
    Pointer<Pointer<OgaSequences>> sequenceHandle = calloc.allocate(sizeOf<Pointer<Pointer<OgaSequences>>>());

    model.OgaCreateSequences(sequenceHandle);

    model.OgaTokenizerEncode(
        tokenizerHandle, stringToPointer(str), sequenceHandle.value);

    return Sequences.create(model, sequenceHandle.value);
  }

  TokenizerStream createStream() {
    return TokenizerStream.create(model, handle, tokenizerHandle);
  }

  // TODO: Add in methods
}
