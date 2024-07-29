import 'dart:ffi';
import 'package:onnx_genai/generated_bindings.dart' as native;

class Sequences {
  final Pointer<native.OgaSequences> sequencesHandle;
  final int numSequences;
  final native.onnx_genai model;

  Sequences(this.model, this.sequencesHandle, this.numSequences);

  factory Sequences.create(model, sequencesHandle) {
    return Sequences(model, sequencesHandle, model.OgaSequencesCount(sequencesHandle).toUnsigned(64));
  }

  List<int> operator [](int sequenceIndex) {
    if (sequenceIndex >= numSequences) {
      throw ArgumentError('sequenceIndex out of range');
    }
    final sequenceLength = model.OgaSequencesGetSequenceCount(sequencesHandle, sequenceIndex.toUnsigned(64)).toUnsigned(64);
    final sequencePtr = model.OgaSequencesGetSequenceData(sequencesHandle, sequenceIndex.toUnsigned(64));

    final sequenceData = sequencePtr.asTypedList(sequenceLength);
    return List.from(sequenceData);
  }

  // TODO: Manage disposal
}