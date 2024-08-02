import 'package:onnx_genai/plugin/onnx_genai_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class OnnxGenAIPlatform extends PlatformInterface {
  /// Constructs a MyPluginPlatform.
  OnnxGenAIPlatform() : super(token: _token);

  static final Object _token = Object();

  static OnnxGenAIPlatform _instance = MethodChannelOnnxGenAI();

  /// The default instance of [MyPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelOnnxGenAI].
  static OnnxGenAIPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyPluginPlatform] when
  /// they register themselves.
  static set instance(OnnxGenAIPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> init() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
