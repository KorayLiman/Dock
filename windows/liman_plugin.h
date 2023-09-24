#ifndef FLUTTER_PLUGIN_LIMAN_PLUGIN_H_
#define FLUTTER_PLUGIN_LIMAN_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace liman {

class LimanPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  LimanPlugin();

  virtual ~LimanPlugin();

  // Disallow copy and assign.
  LimanPlugin(const LimanPlugin&) = delete;
  LimanPlugin& operator=(const LimanPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace liman

#endif  // FLUTTER_PLUGIN_LIMAN_PLUGIN_H_
