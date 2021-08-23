import 'package:polkawallet_plugin_bifrost/store/assets.dart';
import 'package:polkawallet_plugin_bifrost/store/cache/storeCache.dart';

class PluginStore {
  PluginStore(StoreCache cache)
      : assets = AssetsStore(cache);
  final AssetsStore assets;

}
