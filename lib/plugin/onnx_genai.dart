import 'package:onnx_genai/plugin/onnx_genai_interface.dart';

class OnnxGenAI {
  Future<void> init() async {
    return await OnnxGenAIPlatform.instance.init();
  }
}
