library polkawallet_plugin_bifrost;

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:polkawallet_plugin_bifrost/common/constants.dart';
import 'package:polkawallet_plugin_bifrost/service/index.dart';
import 'package:polkawallet_plugin_bifrost/store/cache/storeCache.dart';
import 'package:polkawallet_plugin_bifrost/store/index.dart';
import 'package:polkawallet_plugin_bifrost/utils/i18n/index.dart';
import 'package:polkawallet_sdk/api/types/networkParams.dart';
import 'package:polkawallet_sdk/plugin/homeNavItem.dart';
import 'package:polkawallet_sdk/plugin/index.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/utils/i18n.dart';
import 'package:polkawallet_ui/pages/dAppWrapperPage.dart';
import 'package:polkawallet_ui/pages/txConfirmPage.dart';
import 'package:polkawallet_ui/pages/walletExtensionSignPage.dart';

class PluginBifrost extends PolkawalletPlugin {
  /// the Bifrost plugin supports the Bifrost network
  PluginBifrost()
      : basic = PluginBasicData(
          name: 'bifrost',
          genesisHash: genesis_hash_bifrost,
          ss58: 6,
          primaryColor: bifrost_jaco_blue,
          gradientColor: Colors.cyan,
          backgroundImage: AssetImage(
              'packages/polkawallet_plugin_bifrost/assets/images/public/bg_bifrost.png'),
          icon: Image.asset(
              'packages/polkawallet_plugin_bifrost/assets/images/public/bifrost.png'),
          iconDisabled: Image.asset(
              'packages/polkawallet_plugin_bifrost/assets/images/public/bifrost_gray.png'),
          jsCodeVersion: 20101,
          isTestNet: false,
        ),
        recoveryEnabled = false,
        _cache = StoreCacheBifrost();

  @override
  final PluginBasicData basic;

  @override
  final bool recoveryEnabled;

  @override
  List<NetworkParams> get nodeList {
    return node_list_bifrost.map((e) => NetworkParams.fromJson(e)).toList();
  }


  @override
  final Map<String, Widget> tokenIcons = {
    'ASG': Image.asset(
        'packages/polkawallet_plugin_bifrost/assets/images/tokens/ASG.png'),
  };

  @override
  List<HomeNavItem> getNavItems(BuildContext context, Keyring keyring) {
    return home_nav_items.map((e) {
      final dic = I18n.of(context).getDic(i18n_full_dic_bifrost, 'common');
      return HomeNavItem(
        text: dic[e],
        icon: SvgPicture.asset(
          'packages/polkawallet_plugin_bifrost/assets/images/public/nav_$e.svg',
          color: Theme.of(context).disabledColor,
        ),
        iconActive: SvgPicture.asset(
          'packages/polkawallet_plugin_bifrost/assets/images/public/nav_$e.svg',
          color: basic.primaryColor,
        ),
      );
    }).toList();
  }

  @override
  Map<String, WidgetBuilder> getRoutes(Keyring keyring) {
    return {
      TxConfirmPage.route: (_) =>
          TxConfirmPage(this, keyring, _service.getPassword),

      DAppWrapperPage.route: (_) => DAppWrapperPage(this, keyring),
      WalletExtensionSignPage.route: (_) =>
          WalletExtensionSignPage(this, keyring, _service.getPassword),
    };
  }

  @override
  Future<String> loadJSCode() => rootBundle.loadString(
      'packages/polkawallet_plugin_bifrost/lib/js_api_bifrost/dist/main.js');

  PluginStore _store;
  PluginApi _service;
  PluginStore get store => _store;
  PluginApi get service => _service;

  final StoreCache _cache;

  @override
  Future<void> onWillStart(Keyring keyring) async {
    await GetStorage.init(plugin_bifrost_storage_key);

    _store = PluginStore(_cache);

    try {
      print('bifrost plugin cache data loaded');
    } catch (err) {
      print(err);
      print('load bifrost cache data failed');
    }

    _service = PluginApi(this, keyring);
  }
}
