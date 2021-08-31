import 'package:polkawallet_plugin_bifrost/polkawallet_plugin_bifrost.dart';
import 'package:polkawallet_plugin_bifrost/store/index.dart';
import 'package:polkawallet_sdk/plugin/store/balances.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';

class ServiceAssets {
  ServiceAssets(this.plugin, this.keyring) : store = plugin.store;

  final PluginBifrost plugin;
  final Keyring keyring;
  final PluginStore store;

  final Map _tokenBalances = {};
  final _tokenBalanceChannel = 'tokenBalance';
  final _priceSubscribeChannel = 'BifrostPrices';

  Future<void> _subscribeTokenBalances(
      String address, List tokens, Function(Map) callback) async {
    tokens.forEach((e) {
      final symbol = e['Token'] != null
          ? e['Token']
          : e['VSToken'] != null
          ? 'vs${e['VSToken']}'
          : e['Stable'] != null
          ? e['Stable']
          : "vsBOND";

      final channel = '$_tokenBalanceChannel$e';
      plugin.sdk.api.subscribeMessage(
        'api.query.tokens.accounts',
        [address, e],
        channel,
            (Map data) {
          callback({'symbol': symbol, 'balance': data});
        },
      );
    });
  }

  Future<void> subscribeTokenBalances(
      String address, Function(List<TokenBalanceData>) callback) async {
    final tokens = List.of([
      {"VSToken": "KSM"},
      {"Token": "KSM"},
      {"Stable": "KUSD"},
      {
        "VSBond": ["BNC", 2001, 13, 20]
      }
    ]);

    _tokenBalances.clear();

    await _subscribeTokenBalances(address, tokens, (Map data) {
      _tokenBalances[data['symbol']] = data;

      // do not callback if we did not receive enough data.
      if (_tokenBalances.keys.length < tokens.length) return;

      callback(_tokenBalances.values
          .map((e) => TokenBalanceData(
        id: e['symbol'],
        name: e['symbol'],
        symbol: e['symbol'],
        decimals: 12,
        amount: e['symbol'] == 'vsBOND' || e['symbol'] == 'vsKSM'
            ? (BigInt.parse(e['balance']['reserved'].toString()) +
            BigInt.parse(e['balance']['free'].toString()))
            .toString()
            : e['balance']['free'].toString(),
      ))
          .toList());
    });
  }

  void unsubscribeTokenBalances(String address) async {
    final tokens =
    List.of(plugin.networkConst['syntheticTokens']['syntheticCurrencyIds']);
    tokens.forEach((e) {
      plugin.sdk.api.unsubscribeMessage('$_tokenBalanceChannel$e');
    });
  }

  Future<void> subscribeTokenPrices() async {
    await plugin.sdk.api.service.webView.subscribeMessage(
      'bifrost.subscribeMessage(bifrostApi, "currencies", "oracleValues", ["Aggregated"], "$_priceSubscribeChannel")',
      _priceSubscribeChannel,
          (List res) {
        store.assets.setTokenPrices(res);
      },
    );
  }
}
