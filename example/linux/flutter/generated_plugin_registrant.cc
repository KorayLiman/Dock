//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <liman/liman_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) liman_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "LimanPlugin");
  liman_plugin_register_with_registrar(liman_registrar);
}
