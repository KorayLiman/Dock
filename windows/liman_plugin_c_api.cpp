#include "include/liman/liman_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "liman_plugin.h"

void LimanPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  liman::LimanPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
