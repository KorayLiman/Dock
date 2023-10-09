#include "include/dock/dock_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "dock_plugin.h"

void DockPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  dock::DockPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
