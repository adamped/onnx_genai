import 'dart:ffi';
import 'package:onnx_genai/generated_bindings.dart';
import 'package:onnx_genai/utils.dart';

class Result {
  static String getErrorMessage(onnx_genai model, Pointer<OgaResult> result) {
    return pointerToString(model.OgaResultGetError(result));
  }

  static void verifySuccess(onnx_genai model, Pointer<OgaResult> ptr) {
    if (ptr.address != 0) {
      throw Exception(getErrorMessage(model, ptr));
    }
  }
}
