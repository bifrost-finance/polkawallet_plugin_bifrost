import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:polkawallet_plugin_bifrost/polkawallet_plugin_bifrost.dart';
import 'package:polkawallet_ui/utils/format.dart';

class BifrostServiceAssets {
  BifrostServiceAssets(this.plugin);

  final PluginBifrost plugin;

  Timer _tokenPricesSubscribeTimer;

  final tokenBalanceChannel = 'tokenBalance';

  Future<List> getAllTokenSymbols(String chain) async {
    return await plugin.sdk.webView
        .evalJavascript('bifrost.getAllTokenSymbols("$chain")');
  }

  void unsubscribeTokenBalances(String chain, String address) async {
    final tokens = await getAllTokenSymbols(chain);
    tokens.forEach((e) {
      plugin.sdk.api.unsubscribeMessage('$tokenBalanceChannel${e['token']}');
    });
  }

  Future<void> subscribeTokenBalances(
      String address, List tokens, Function(Map) callback) async {
    tokens.forEach((e) {
      String symbol;
      switch (e.keys.toList().first) {
        case 'VSToken':
          {
            symbol = 'vs${e['VSToken']}';
          }
          break;
        case 'Stable':
          {
            symbol = e['Stable'];
          }
          break;
        case 'VSBond':
          {
            symbol = 'vsBOND';
          }
          break;
        case 'Token':
          {
            symbol = e['Token'];
          }
          break;
        case 'LPToken':
          if (listEquals(e[e.keys.toList().first], ["KAR", 2, "ZLK", 2])) {
            symbol = 'KAR-ZLK';
            break;
          } else if (listEquals(
              e[e.keys.toList().first], ["KSM", 2, "KSM", 4])) {
            symbol = 'vsKSM-KSM';
            break;
          } else if (listEquals(
              e[e.keys.toList().first], ["ASG", 0, "KSM", 2])) {
            symbol = 'BNC-KSM';
            break;
          } else if (listEquals(
              e[e.keys.toList().first], ["KSM", 2, "KUSD", 3])) {
            symbol = 'KSM-kUSD';
            break;
          } else if (listEquals(
              e[e.keys.toList().first], ["ASG", 0, "ZLK", 2])) {
            symbol = 'BNC-ZLK';
            break;
          }
          break;
        default:
          {
            symbol = e['Token'];
          }
          break;
      }

      final channel = '$tokenBalanceChannel$e';
      plugin.sdk.api.subscribeMessage(
        'api.query.tokens.accounts',
        [address, e],
        channel,
        (Map data) {
          callback({
            'symbol': symbol,
            'name': symbol,
            'decimals': 12,
            'balance': data
          });
        },
      );
    });
  }

  Future<void> subscribeTokenPrices(
      Function(Map<String, BigInt>) callback) async {
    final List res = await plugin.sdk.webView
        .evalJavascript('api.rpc.oracle.getAllValues("Aggregated")');
    if (res != null) {
      final prices = Map<String, BigInt>();
      res.forEach((e) {
        prices[e[0]['token']] = Fmt.balanceInt(e[1]['value'].toString());
      });
      callback(prices);
    }

    _tokenPricesSubscribeTimer =
        Timer(Duration(seconds: 10), () => subscribeTokenPrices(callback));
  }

  void unsubscribeTokenPrices() {
    if (_tokenPricesSubscribeTimer != null) {
      _tokenPricesSubscribeTimer.cancel();
      _tokenPricesSubscribeTimer = null;
    }
  }

  Future<bool> checkExistentialDepositForTransfer(
    String address,
    String token,
    int decimal,
    String amount, {
    String direction = 'to',
  }) async {
    final res = await plugin.sdk.webView.evalJavascript(
        'bifrost.checkExistentialDepositForTransfer(api, "$address", "$token", $decimal, $amount, "$direction")');
    return res['result'] as bool;
  }
}
