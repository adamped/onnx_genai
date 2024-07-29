# ONNX Runtime GenAI Flutter Wrapper

** Experimental **

A wrapper around the Microsoft GenAI library that contains the Microsoft ONNX extensions required for interacting with Phi based models.

## Getting Started

Initialize the model and tokenizer.

Download any compatible onnxruntime-genai model.

https://huggingface.co/collections/EmbeddedLLM/onnx-genai-6671a24baf00e07508ef9062

And place in your assets directory

```
var model = Model.create('assets/phi-3-mini');

var tokenizer = Tokenizer.create(model.genai, model.handle);

var tokenizerStream = tokenizer.createStream();
```

Next you can perform inference as required. This method waits until the output is finished, but you could also stream the output.

```
String inference(String text) {
    var prompt = '<|user|>\n$text <|end|>\n<|assistant|>';

    var tokens = tokenizer.encode(prompt);

    var params = GeneratorParams.create(model.genai, model.handle);

    params.setInputIds(tokens);

    var generator = Generator.create(model.genai, model.handle, params.handle);

    var output = '';

    while (!generator.isDone()) {
        generator.computeLogits();
        generator.generateNextToken();
        var newToken = generator.getSequence(0).last;

        output += tokenizerStream.decode(newToken);
    }

    return output;
}
```

## Build Configuration

If you are running on linux ensure that the clang directories are included in your path. Add the following to `~/.bashrc`

```
export CPATH="$(clang -v 2>&1 | grep "Selected GCC installation" | rev | cut -d' ' -f1 | rev)/include"
```

In the root directory of the project run:

```
dart run ffigen
```

This uses the headers in `include/ort_genai_c.h` to build the bindings. The header file comes from https://github.com/microsoft/onnxruntime-genai

Download the latest release for the headers and .so file. The header file was modified slightly to make it C compatible for ffigen.

