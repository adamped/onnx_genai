#include "include/onnx_genai/onnx_gen_a_i.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>

#include <cstring>
#include <iostream>
#include "onnx_genai_private.h"

#define ONNX_GENAI(obj)                                       \
    (G_TYPE_CHECK_INSTANCE_CAST((obj), onnx_genai_get_type(), \
                                OnnxGenAI))

struct _OnnxGenAI
{
    GObject parent_instance;
};

G_DEFINE_TYPE(OnnxGenAI, onnx_genai, g_object_get_type())

// Called when a method call is received from Flutter.
static void onnx_genai_handle_method_call(
    OnnxGenAI *self,
    FlMethodCall *method_call)
{
    g_autoptr(FlMethodResponse) response = nullptr;

    const gchar *method = fl_method_call_get_name(method_call);

    if (strcmp(method, "init") == 0)
    {
        response = init();
    }
    else
    {
        response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
    }

    fl_method_call_respond(method_call, response, nullptr);
}

FlMethodResponse *init()
{
    struct utsname uname_data = {};
    uname(&uname_data);
    g_autofree gchar *version = g_strdup_printf("Linux %s", uname_data.version);
    g_autoptr(FlValue) result = fl_value_new_string(version);
    return FL_METHOD_RESPONSE(fl_method_success_response_new(result));
}

static void onnx_genai_dispose(GObject *object)
{
    G_OBJECT_CLASS(onnx_genai_parent_class)->dispose(object);
}

static void onnx_genai_class_init(OnnxGenAIClass *klass)
{
    G_OBJECT_CLASS(klass)->dispose = onnx_genai_dispose;
}

static void onnx_genai_init(OnnxGenAI *self) {}

static void method_call_cb(FlMethodChannel *channel, FlMethodCall *method_call,
                           gpointer user_data)
{
    OnnxGenAI *plugin = ONNX_GENAI(user_data);
    onnx_genai_handle_method_call(plugin, method_call);
}

void onnx_gen_a_i_register_with_registrar(FlPluginRegistrar *registrar)
{
    OnnxGenAI *plugin = ONNX_GENAI(
        g_object_new(onnx_genai_get_type(), nullptr));

    g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
    g_autoptr(FlMethodChannel) channel =
        fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                              "onnx_genai",
                              FL_METHOD_CODEC(codec));
    fl_method_channel_set_method_call_handler(channel, method_call_cb,
                                              g_object_ref(plugin),
                                              g_object_unref);

    g_object_unref(plugin);
}
