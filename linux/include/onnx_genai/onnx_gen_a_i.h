#ifndef FLUTTER_PLUGIN_ONNX_GENAI_H_
#define FLUTTER_PLUGIN_ONNX_GENAI_H_

#include <flutter_linux/flutter_linux.h>

G_BEGIN_DECLS

#ifdef FLUTTER_PLUGIN_IMPL
#define FLUTTER_PLUGIN_EXPORT __attribute__((visibility("default")))
#else
#define FLUTTER_PLUGIN_EXPORT
#endif

typedef struct _OnnxGenAI OnnxGenAI;
typedef struct
{
    GObjectClass parent_class;
} OnnxGenAIClass;

FLUTTER_PLUGIN_EXPORT GType onnx_genai_get_type();

FLUTTER_PLUGIN_EXPORT void onnx_gen_a_i_register_with_registrar(
    FlPluginRegistrar *registrar);

G_END_DECLS

#endif
