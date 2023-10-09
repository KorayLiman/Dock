#ifndef FLUTTER_PLUGIN_DOCK_PLUGIN_H_
#define FLUTTER_PLUGIN_DOCK_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace dock {

class DockPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  DockPlugin();

  virtual ~DockPlugin();

  // Disallow copy and assign.
  DockPlugin(const DockPlugin&) = delete;
  DockPlugin& operator=(const DockPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace dock

#endif  // FLUTTER_PLUGIN_DOCK_PLUGIN_H_
