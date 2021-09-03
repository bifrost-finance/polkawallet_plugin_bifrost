import 'package:polkawallet_plugin_bifrost/api/assets/bifrostServiceAssets.dart';
import 'package:polkawallet_plugin_bifrost/polkawallet_plugin_bifrost.dart';

class BifrostService {
  BifrostService(PluginBifrost plugin)
      : assets = BifrostServiceAssets(plugin);

  final BifrostServiceAssets assets;
}
