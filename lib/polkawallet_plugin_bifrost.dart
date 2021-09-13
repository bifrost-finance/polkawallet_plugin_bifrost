library polkawallet_plugin_bifrost;

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:polkawallet_plugin_bifrost/api/bifrostApi.dart';
import 'package:polkawallet_plugin_bifrost/api/bifrostService.dart';
import 'package:polkawallet_plugin_bifrost/common/constants/index.dart';
import 'package:polkawallet_plugin_bifrost/common/constants/nodeList.dart';
import 'package:polkawallet_plugin_bifrost/pages/assets/tokenDetailPage.dart';
import 'package:polkawallet_plugin_bifrost/pages/assets/transferDetailPage.dart';
import 'package:polkawallet_plugin_bifrost/pages/assets/transferPage.dart';
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
  PluginBifrost()
      : basic = PluginBasicData(
          name: 'bifrost',
          genesisHash: bifrost_genesis_hash,
          ss58: 6,
          primaryColor:  bifrost_jaco_blue,
          icon: Image.asset(
              'packages/polkawallet_plugin_bifrost/assets/images/public/bifrost.png'),
          iconDisabled: Image.asset(
              'packages/polkawallet_plugin_bifrost/assets/images/public/bifrost_gray.png'),
          jsCodeVersion: 20601,
          isTestNet: false,
          parachainId: '2001',
        );

  @override
  final PluginBasicData basic;

  @override
  List<NetworkParams> get nodeList {
    return _randomList(node_list)
        .map((e) => NetworkParams.fromJson(e))
        .toList();
  }

  Map<String, Widget> _getTokenIcons() {
    final Map<String, Widget> all = {};
    bifrost_token_ids.forEach((token) {
      all[token] = Image.asset(
          'packages/polkawallet_plugin_bifrost/assets/images/tokens/$token.png');
    });
    return all;
  }

  @override
  Map<String, Widget> get tokenIcons => _getTokenIcons();

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

      TokenDetailPage.route: (_) => TokenDetailPage(this, keyring),
      TransferPage.route: (_) => TransferPage(this, keyring),
      TransferDetailPage.route: (_) => TransferDetailPage(this, keyring),
    };
  }

  @override
  Future<String> loadJSCode() => rootBundle.loadString(
      'packages/polkawallet_plugin_bifrost/lib/js_service_bifrost/dist/main.js');

  BifrostApi _api;
  BifrostApi get api => _api;

  StoreCache _cache;
  PluginStore _store;
  PluginService _service;
  PluginStore get store => _store;
  PluginService get service => _service;

  Future<void> _subscribeTokenBalances(KeyPairData acc) async {
    final enabled = true;

    _api.assets.subscribeTokenBalances(basic.name, acc.address, (data) {
      _store.assets.setTokenBalanceMap(data, acc.pubKey);

      balances.setTokens(data);
    }, transferEnabled: enabled);
  }

  void _loadCacheData(KeyPairData acc) {
    balances.setExtraTokens([]);

    try {
      loadBalances(acc);

      _store.assets.loadCache(acc.pubKey);
      balances.setTokens(_store.assets.tokenBalanceMap.values.toList(),
          isFromCache: true);

      print('Bifrost plugin cache data loaded');
    } catch (err) {
      print(err);
      print('load Bifrost cache data failed');
    }
  }

  @override
  Future<void> onWillStart(Keyring keyring) async {
    _api = BifrostApi(BifrostService(this));

    await GetStorage.init(bifrost_plugin_cache_key);

    _cache = StoreCache();
    _store = PluginStore(_cache);
    _loadCacheData(keyring.current);

    _service = PluginService(this, keyring);
  }

  @override
  Future<void> onStarted(Keyring keyring) async {
    _service.connected = true;

    if (keyring.current.address != null) {
      _subscribeTokenBalances(keyring.current);
    }
  }

  @override
  Future<void> onAccountChanged(KeyPairData acc) async {
    _loadCacheData(acc);

    if (_service.connected) {
      _api.assets.unsubscribeTokenBalances(basic.name, acc.address);
      _subscribeTokenBalances(acc);
    }
  }

  List _randomList(List input) {
    final data = input.toList();
    final res = [];
    final _random = Random();
    for (var i = 0; i < input.length; i++) {
      final item = data[_random.nextInt(data.length)];
      res.add(item);
      data.remove(item);
    }
    return res;
  }
}
