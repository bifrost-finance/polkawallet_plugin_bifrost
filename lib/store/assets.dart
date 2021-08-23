import 'package:mobx/mobx.dart';
import 'package:polkawallet_plugin_bifrost/store/cache/storeCache.dart';
import 'package:polkawallet_plugin_bifrost/store/types/bifrostCurrenciesData.dart';
import 'package:polkawallet_sdk/plugin/store/balances.dart';

part 'assets.g.dart';

class AssetsStore extends _AssetsStore with _$AssetsStore {
  AssetsStore(StoreCache cache) : super(cache);
}

abstract class _AssetsStore with Store {
  _AssetsStore(this.cache);

  final StoreCache cache;

  @observable
  Map<String, TokenBalanceData> tokenBalanceMap =
      Map<String, TokenBalanceData>();

  @observable
  Map<String, BifrostPriceData> tokenPrices = {};

  @action
  void setTokenBalanceMap(List<TokenBalanceData> list) {
    final data = Map<String, TokenBalanceData>();
    list.forEach((e) {
      data[e.symbol] = e;
    });
    tokenBalanceMap = data;
  }

  @action
  void setTokenPrices(List prices) {
    final Map<String, BifrostPriceData> res = {};
    prices.forEach((e) {
      res[e['tokenId']] = BifrostPriceData.fromJson(e);
    });
    tokenPrices = res;
  }
}
