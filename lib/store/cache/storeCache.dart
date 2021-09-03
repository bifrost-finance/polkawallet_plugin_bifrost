import 'package:get_storage/get_storage.dart';
import 'package:polkawallet_plugin_bifrost/common/constants.dart';

class StoreCache {
  static final _storage = () => GetStorage(bifrost_plugin_cache_key);

  final tokens = {}.val('tokens', getBox: _storage);
}

class StoreCacheKar extends StoreCache {
  static final _storage =
      () => GetStorage(bifrost_plugin_cache_key);

  final tokens = {}.val('tokens', getBox: _storage);
}
