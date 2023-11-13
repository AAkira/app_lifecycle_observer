//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <app_lifecycle_observer/app_lifecycle_observer_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) app_lifecycle_observer_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "AppLifecycleObserverPlugin");
  app_lifecycle_observer_plugin_register_with_registrar(app_lifecycle_observer_registrar);
}
