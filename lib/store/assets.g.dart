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

  final _$tokenPricesAtom = Atom(name: '_AssetsStore.tokenPrices');

  @override
  Map<String, BifrostPriceData> get tokenPrices {
    _$tokenPricesAtom.reportRead();
    return super.tokenPrices;
  }

  @override
  set tokenPrices(Map<String, BifrostPriceData> value) {
    _$tokenPricesAtom.reportWrite(value, super.tokenPrices, () {
      super.tokenPrices = value;
    });
  }

  final _$_AssetsStoreActionController = ActionController(name: '_AssetsStore');

  @override
  void setTokenBalanceMap(List<TokenBalanceData> list) {
    final _$actionInfo = _$_AssetsStoreActionController.startAction(
        name: '_AssetsStore.setTokenBalanceMap');
    try {
      return super.setTokenBalanceMap(list);
    } finally {
      _$_AssetsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTokenPrices(List<dynamic> prices) {
    final _$actionInfo = _$_AssetsStoreActionController.startAction(
        name: '_AssetsStore.setTokenPrices');
    try {
      return super.setTokenPrices(prices);
    } finally {
      _$_AssetsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tokenBalanceMap: ${tokenBalanceMap},
tokenPrices: ${tokenPrices}
    ''';
  }
}
