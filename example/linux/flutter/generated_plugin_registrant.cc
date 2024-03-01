//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <dock_flutter/dock_flutter_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) dock_flutter_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DockFlutterPlugin");
  dock_flutter_plugin_register_with_registrar(dock_flutter_registrar);
}
