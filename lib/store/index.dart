import 'package:polkawallet_plugin_bifrost/store/accounts.dart';
import 'package:polkawallet_plugin_bifrost/store/cache/storeCache.dart';


class PluginStore {
  PluginStore(StoreCache cache);

  final AccountsStore accounts = AccountsStore();
}
