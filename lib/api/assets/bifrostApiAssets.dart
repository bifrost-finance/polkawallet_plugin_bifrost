import 'package:polkawallet_plugin_bifrost/api/assets/bifrostServiceAssets.dart';
import 'package:polkawallet_plugin_bifrost/pages/assets/tokenDetailPage.dart';
import 'package:polkawallet_sdk/plugin/store/balances.dart';

class BifrostApiAssets {
  BifrostApiAssets(this.service);

  final BifrostServiceAssets service;

  final Map _tokenBalances = {};

  Future<List> getAllTokenSymbols(String chain) async {
    return await service.getAllTokenSymbols(chain);
  }

  void unsubscribeTokenBalances(String chain, String address) {
    service.unsubscribeTokenBalances(chain, address);
  }

  Future<void> subscribeTokenBalances(
      String chain, String address, Function(List<TokenBalanceData>) callback,
      {bool transferEnabled = true}) async {
    final tokens = List.of([
      {"VSToken": "KSM"},
      {"Token": "KSM"},
      {"Stable": "KUSD"},
      {
        "VSBond": ["BNC", 2001, 13, 20]
      }
    ]);
    _tokenBalances.clear();

    await service.subscribeTokenBalances(address, tokens, (Map data) {
      _tokenBalances[data['symbol']] = data;

      // do not callback if we did not receive enough data.
      if (_tokenBalances.keys.length < tokens.length) return;
      callback(_tokenBalances.values
          .map((e) => TokenBalanceData(
                id: e['symbol'],
                symbol: e['symbol'],
                name: e['name'],
                decimals: 12,
                amount: e['balance']['free'].toString(),
                locked: e['balance']['frozen'].toString(),
                reserved: e['balance']['reserved'].toString(),
                detailPageRoute: transferEnabled ? TokenDetailPage.route : null,
              ))
          .toList());
    });
  }

  Future<void> subscribeTokenPrices(
      Function(Map<String, BigInt>) callback) async {
    service.subscribeTokenPrices(callback);
  }

  void unsubscribeTokenPrices() {
    service.unsubscribeTokenPrices();
  }

  Future<bool> checkExistentialDepositForTransfer(
    String address,
    String token,
    int decimal,
    String amount, {
    String direction = 'to',
  }) async {
    return service.checkExistentialDepositForTransfer(
        address, token, decimal, amount);
  }
}
