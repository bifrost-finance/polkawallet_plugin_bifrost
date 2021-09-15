import 'package:polkawallet_plugin_bifrost/store/accounts.dart';
import 'package:polkawallet_plugin_bifrost/store/assets.dart';
import 'package:polkawallet_plugin_bifrost/store/gov/governance.dart';
import 'package:polkawallet_plugin_bifrost/store/cache/storeCache.dart';
import 'package:polkawallet_plugin_bifrost/store/setting.dart';

class PluginStore {
  PluginStore(StoreCache cache)
      : setting = SettingStore(cache),
        gov = GovernanceStore(cache),
        assets = AssetsStore(cache);

  final accounts = AccountsStore();

  final SettingStore setting;
  final AssetsStore assets;
  final GovernanceStore gov;
}
