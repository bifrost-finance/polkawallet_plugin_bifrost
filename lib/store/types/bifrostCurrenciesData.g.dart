// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bifrostCurrenciesData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BifrostTokenData _$BifrostTokenDataFromJson(Map<String, dynamic> json) {
  return BifrostTokenData()
    ..name = json['name'] as String
    ..symbol = json['symbol'] as String
    ..id = json['id'] as String
    ..precision = json['precision'] as int
    ..isBaseToken = json['isBaseToken'] as bool
    ..isNetworkToken = json['isNetworkToken'] as bool;
}

Map<String, dynamic> _$BifrostTokenDataToJson(BifrostTokenData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
      'id': instance.id,
      'precision': instance.precision,
      'isBaseToken': instance.isBaseToken,
      'isNetworkToken': instance.isNetworkToken,
    };

BifrostBalanceData _$BifrostBalanceDataFromJson(Map<String, dynamic> json) {
  return BifrostBalanceData()
    ..tokenId = json['tokenId'] as String
    ..free = json['free'] as String;
}

Map<String, dynamic> _$BifrostBalanceDataToJson(BifrostBalanceData instance) =>
    <String, dynamic>{
      'tokenId': instance.tokenId,
      'free': instance.free,
    };

BifrostPriceData _$BifrostPriceDataFromJson(Map<String, dynamic> json) {
  return BifrostPriceData()
    ..tokenId = json['tokenId'] as String
    ..value = json['value'] as String
    ..timestamp = json['timestamp'] as int;
}

Map<String, dynamic> _$BifrostPriceDataToJson(BifrostPriceData instance) =>
    <String, dynamic>{
      'tokenId': instance.tokenId,
      'value': instance.value,
      'timestamp': instance.timestamp,
    };
