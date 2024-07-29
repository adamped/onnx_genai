import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:onnx_genai/generated_bindings.dart';

class Generator {
  final Pointer<OgaGenerator> handle;
  onnx_genai model;

  Generator(this.handle, this.model);

  factory Generator.create(onnx_genai model, Pointer<OgaModel> modelHandle,
      Pointer<OgaGeneratorParams> params) {
    Pointer<Pointer<OgaGenerator>> out = calloc.allocate(sizeOf<Pointer<Pointer<OgaGeneratorParams>>>());

    model.OgaCreateGenerator(modelHandle, params, out);

    return Generator(out.value, model);
  }

  bool isDone() {
    return model.OgaGenerator_IsDone(handle);
  }

  void computeLogits() {
    model.OgaGenerator_ComputeLogits(handle);
  }

  void generateNextToken() {
    model.OgaGenerator_GenerateNextToken(handle);
  }

  List<int> getSequence(int index) {
    int length = model.OgaGenerator_GetSequenceCount(handle, index);

    var ptr = model.OgaGenerator_GetSequenceData(handle, index);

    final list = List<int>.from(ptr.asTypedList(length));
    return List.unmodifiable(list);
  }

  // TODO: Add in methods
}
