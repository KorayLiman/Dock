//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <dock/dock_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) dock_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DockPlugin");
  dock_plugin_register_with_registrar(dock_registrar);
}
