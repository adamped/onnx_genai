import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:onnx_genai/generated_bindings.dart';
import 'package:onnx_genai/sequences.dart';

class GeneratorParams {
  final Pointer<OgaGeneratorParams> handle;
  final onnx_genai model;

  GeneratorParams(this.handle, this.model);

  factory GeneratorParams.create(
      onnx_genai model, Pointer<OgaModel> modelHandle) {
    Pointer<Pointer<OgaGeneratorParams>> out =
        calloc.allocate(sizeOf<Pointer<Pointer<OgaGeneratorParams>>>());

    model.OgaCreateGeneratorParams(modelHandle, out);

    return GeneratorParams(out.value, model);
  }

  void setInputIds(Sequences sequences) {
    model.OgaGeneratorParamsSetInputSequences(
        handle, sequences.sequencesHandle);
  }

  // TODO: Add in methods
}
