import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:onnx_genai/plugin/onnx_genai_interface.dart';

class MethodChannelOnnxGenAI extends OnnxGenAIPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('onnx_genai');

  @override
  Future<void> init() async {
    await methodChannel.invokeMethod<String>('init');
  }
}
