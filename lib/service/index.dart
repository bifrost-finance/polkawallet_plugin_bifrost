import 'package:flutter/cupertino.dart';
import 'package:polkawallet_plugin_bifrost/polkawallet_plugin_bifrost.dart';
import 'package:polkawallet_plugin_bifrost/service/serviceAssets.dart';
import 'package:polkawallet_plugin_bifrost/service/serviceGov.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/storage/types/keyPairData.dart';
import 'package:polkawallet_sdk/utils/i18n.dart';
import 'package:polkawallet_ui/components/passwordInputDialog.dart';
import 'package:polkawallet_ui/utils/i18n.dart';

class PluginService {
  PluginService(PluginBifrost plugin, Keyring keyring)
      : assets = ServiceAssets(plugin, keyring),
        gov = ServiceGov(plugin, keyring),
        plugin = plugin;
  final ServiceAssets assets;
  final ServiceGov gov;

  final PluginBifrost plugin;

  bool connected = false;

  Future<String> getPassword(BuildContext context, KeyPairData acc) async {
    final password = await showCupertinoDialog(
      context: context,
      builder: (_) {
        return PasswordInputDialog(
          plugin.sdk.api,
          title: Text(
              I18n.of(context).getDic(i18n_full_dic_ui, 'common')['unlock']),
          account: acc,
        );
      },
    );
    return password;
  }
}
