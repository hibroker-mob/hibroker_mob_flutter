//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <audioplayers_linux/audioplayers_linux_plugin.h>
#include <sim_card_info/sim_card_info_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) audioplayers_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "AudioplayersLinuxPlugin");
  audioplayers_linux_plugin_register_with_registrar(audioplayers_linux_registrar);
  g_autoptr(FlPluginRegistrar) sim_card_info_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "SimCardInfoPlugin");
  sim_card_info_plugin_register_with_registrar(sim_card_info_registrar);
}
