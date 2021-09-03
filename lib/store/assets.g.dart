// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AssetsStore on _AssetsStore, Store {
  final _$tokenBalanceMapAtom = Atom(name: '_AssetsStore.tokenBalanceMap');

  @override
  Map<String, TokenBalanceData> get tokenBalanceMap {
    _$tokenBalanceMapAtom.reportRead();
    return super.tokenBalanceMap;
  }

  @override
  set tokenBalanceMap(Map<String, TokenBalanceData> value) {
    _$tokenBalanceMapAtom.reportWrite(value, super.tokenBalanceMap, () {
      super.tokenBalanceMap = value;
    });
  }

  final _$pricesAtom = Atom(name: '_AssetsStore.prices');

  @override
  Map<String, BigInt> get prices {
    _$pricesAtom.reportRead();
    return super.prices;
  }

  @override
  set prices(Map<String, BigInt> value) {
    _$pricesAtom.reportWrite(value, super.prices, () {
      super.prices = value;
    });
  }

  final _$marketPricesAtom = Atom(name: '_AssetsStore.marketPrices');

  @override
  ObservableMap<String, double> get marketPrices {
    _$marketPricesAtom.reportRead();
    return super.marketPrices;
  }

  @override
  set marketPrices(ObservableMap<String, double> value) {
    _$marketPricesAtom.reportWrite(value, super.marketPrices, () {
      super.marketPrices = value;
    });
  }

  final _$txsAtom = Atom(name: '_AssetsStore.txs');

  @override
  ObservableList<TransferData> get txs {
    _$txsAtom.reportRead();
    return super.txs;
  }

  @override
  set txs(ObservableList<TransferData> value) {
    _$txsAtom.reportWrite(value, super.txs, () {
      super.txs = value;
    });
  }

  final _$_AssetsStoreActionController = ActionController(name: '_AssetsStore');

  @override
  void setTokenBalanceMap(List<TokenBalanceData> list, String pubKey,
      {bool shouldCache = true}) {
    final _$actionInfo = _$_AssetsStoreActionController.startAction(
        name: '_AssetsStore.setTokenBalanceMap');
    try {
      return super.setTokenBalanceMap(list, pubKey, shouldCache: shouldCache);
    } finally {
      _$_AssetsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPrices(Map<String, BigInt> data) {
    final _$actionInfo = _$_AssetsStoreActionController.startAction(
        name: '_AssetsStore.setPrices');
    try {
      return super.setPrices(data);
    } finally {
      _$_AssetsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMarketPrices(Map<String, double> data) {
    final _$actionInfo = _$_AssetsStoreActionController.startAction(
        name: '_AssetsStore.setMarketPrices');
    try {
      return super.setMarketPrices(data);
    } finally {
      _$_AssetsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTxs(List<dynamic> list, int decimals) {
    final _$actionInfo =
        _$_AssetsStoreActionController.startAction(name: '_AssetsStore.setTxs');
    try {
      return super.setTxs(list, decimals);
    } finally {
      _$_AssetsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadCache(String pubKey) {
    final _$actionInfo = _$_AssetsStoreActionController.startAction(
        name: '_AssetsStore.loadCache');
    try {
      return super.loadCache(pubKey);
    } finally {
      _$_AssetsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tokenBalanceMap: ${tokenBalanceMap},
prices: ${prices},
marketPrices: ${marketPrices},
txs: ${txs},
    ''';
  }
}
