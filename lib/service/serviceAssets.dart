import 'package:polkawallet_plugin_bifrost/api/bifrostApi.dart';
import 'package:polkawallet_plugin_bifrost/polkawallet_plugin_bifrost.dart';
import 'package:polkawallet_plugin_bifrost/service/walletApi.dart';
import 'package:polkawallet_plugin_bifrost/store/index.dart';
import 'package:polkawallet_sdk/plugin/store/balances.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';

class ServiceAssets {
  ServiceAssets(this.plugin, this.keyring)
      : api = plugin.api,
        store = plugin.store;

  final PluginBifrost plugin;
  final Keyring keyring;
  final BifrostApi api;
  final PluginStore store;

  Future<void> updateTokenBalances(String tokenId) async {
    String currencyId = tokenId == 'vsKSM'
        ? '{VSToken: "KSM"}'
        : tokenId == 'KUSD'
            ? '{Stable: "$tokenId"}'
            : tokenId == 'vsBOND'
                ? '{vsBond: ["BNC",2001,13,20]}'
                : '{Token: "$tokenId"}';


    final res = await plugin.sdk.webView.evalJavascript(
        'api.query.tokens.accounts("${keyring.current.address}", $currencyId)');

    final balances =
        Map<String, TokenBalanceData>.from(store.assets.tokenBalanceMap);

    final data = TokenBalanceData(
        id: balances[tokenId].id,
        name: balances[tokenId].name,
        symbol: balances[tokenId].symbol,
        decimals: balances[tokenId].decimals,
        amount: res['free'].toString(),
        locked: res['frozen'].toString(),
        reserved: res['reserved'].toString(),
        detailPageRoute: balances[tokenId].detailPageRoute,
        price: balances[tokenId].price);
    balances[tokenId] = data;

    store.assets
        .setTokenBalanceMap(balances.values.toList(), keyring.current.pubKey);
    plugin.balances.setTokens([data]);
  }
}
