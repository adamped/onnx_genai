import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:onnx_genai/generated_bindings.dart' as native;
import 'package:onnx_genai/generator_params.dart';
import 'package:onnx_genai/result.dart';
import 'package:onnx_genai/sequences.dart';
import 'package:onnx_genai/utils.dart';

class Model {
  Pointer<native.OgaModel> _modelHandle;
  native.onnx_genai genai;

  Pointer<native.OgaModel> get handle => _modelHandle; //TODO: Hide in future

  Model(this.genai, this._modelHandle);

  factory Model.create(String modelPath, DynamicLibrary lib) {
    Pointer<Pointer<native.OgaModel>> outModelPtrPtr = calloc.allocate(sizeOf<Pointer<Pointer<native.OgaModel>>>()); 

    var model = native
        .onnx_genai(lib);

    var result = model.OgaCreateModel(stringToPointer(modelPath), outModelPtrPtr);

    Result.verifySuccess(model, result);

    return Model(model, outModelPtrPtr.value);
    
  }

  Sequences generate(GeneratorParams generatorParams) {
    Pointer<Pointer<native.OgaSequences>> outSequencePtrPtr = calloc.allocate(sizeOf<Pointer<Pointer<native.OgaSequences>>>());
    
    genai.OgaGenerate(_modelHandle, generatorParams.handle, outSequencePtrPtr);

    return Sequences.create(genai, outSequencePtrPtr.value);
  }

  // TODO: Handle disposal
}
