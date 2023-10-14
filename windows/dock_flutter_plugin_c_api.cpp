#include "include/dock_flutter/dock_flutter_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "dock_flutter_plugin.h"

void DockFlutterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  dock_flutter::DockFlutterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
