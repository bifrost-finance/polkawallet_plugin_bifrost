library polkawallet_plugin_bifrost;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:polkawallet_plugin_bifrost/common/constants.dart';
import 'package:polkawallet_plugin_bifrost/pages/currencySelectPage.dart';
import 'package:polkawallet_plugin_bifrost/service/index.dart';
import 'package:polkawallet_plugin_bifrost/store/cache/storeCache.dart';
import 'package:polkawallet_plugin_bifrost/store/index.dart';
import 'package:polkawallet_sdk/api/types/networkParams.dart';
import 'package:polkawallet_sdk/plugin/homeNavItem.dart';
import 'package:polkawallet_sdk/plugin/index.dart';
import 'package:polkawallet_sdk/plugin/store/balances.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/storage/types/keyPairData.dart';
import 'package:polkawallet_ui/pages/accountQrCodePage.dart';
import 'package:polkawallet_ui/pages/txConfirmPage.dart';

class PluginBifrost extends PolkawalletPlugin {
  @override
  final basic = PluginBasicData(
    name: 'bifrost',
    genesisHash: bifrost_genesis_hash,
    ss58: 6,
    primaryColor: bifrost_jaco_blue,
    gradientColor: Colors.purple,
    icon: Image.asset(
        'packages/polkawallet_plugin_bifrost/assets/images/public/bifrost.png'),
    iconDisabled: Image.asset(
        'packages/polkawallet_plugin_bifrost/assets/images/public/bifrost_gray.png'),
    jsCodeVersion: 20601,
    isTestNet: false,
  );

  @override
  List<NetworkParams> get nodeList {
    return node_list.map((e) => NetworkParams.fromJson(e)).toList();
  }

  @override
  Map<String, Widget> get tokenIcons => {
        'BNC': Image.asset(
            'packages/polkawallet_plugin_bifrost/assets/images/tokens/BNC.png'),
        'VSKSM': Image.asset(
            'packages/polkawallet_plugin_bifrost/assets/images/tokens/vsKSM.png'),
        'KSM': Image.asset(
            'packages/polkawallet_plugin_bifrost/assets/images/tokens/KSM.png'),
        'KUSD': Image.asset(
            'packages/polkawallet_plugin_bifrost/assets/images/tokens/KUSD.png'),
        'VSBOND': Image.asset(
            'packages/polkawallet_plugin_bifrost/assets/images/tokens/vsBOND.png'),
      };

  @override
  List<TokenBalanceData> get noneNativeTokensAll {
    return store?.assets?.tokenBalanceMap?.values?.toList();
  }

  @override
  List<HomeNavItem> getNavItems(BuildContext context, Keyring keyring) {
    return [];
  }

  @override
  Map<String, WidgetBuilder> getRoutes(Keyring keyring) {
    return {
      TxConfirmPage.route: (_) =>
          TxConfirmPage(this, keyring, _service.getPassword),
      CurrencySelectPage.route: (_) => CurrencySelectPage(this),
      AccountQrCodePage.route: (_) => AccountQrCodePage(this, keyring),
    };
  }

  @override
  Future<String> loadJSCode() => rootBundle.loadString(
      'packages/polkawallet_plugin_bifrost/lib/js_service_bifrost/dist/main.js');

  final StoreCache _cache = StoreCache();
  PluginStore _store;
  PluginService _service;
  PluginStore get store => _store;
  PluginService get service => _service;

  Future<void> _subscribeTokenBalances(KeyPairData acc) async {
    _service.assets.subscribeTokenBalances(acc.address, (data) {
      balances.setTokens(data);
      _store.assets.setTokenBalanceMap(data);
    });
  }

  void _loadCacheData(KeyPairData acc) {
    loadBalances(acc);

    balances.setTokens([]);
  }

  @override
  Future<void> onWillStart(Keyring keyring) async {
    await GetStorage.init(bifrost_plugin_cache_key);

    _store = PluginStore(_cache);
    _loadCacheData(keyring.current);

    _service = PluginService(this, keyring);
  }

  @override
  Future<void> onStarted(Keyring keyring) async {
    _service.connected = true;

    _service.assets.subscribeTokenPrices();
    if (keyring.current.address != null) {
      _subscribeTokenBalances(keyring.current);
    }
  }

  @override
  Future<void> onAccountChanged(KeyPairData acc) async {
    _loadCacheData(acc);

    if (_service.connected) {
      _service.assets.unsubscribeTokenBalances(acc.address);
      _subscribeTokenBalances(acc);
    }
  }
}
