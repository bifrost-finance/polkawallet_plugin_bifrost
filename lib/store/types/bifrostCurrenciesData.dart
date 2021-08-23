import 'package:json_annotation/json_annotation.dart';

part 'bifrostCurrenciesData.g.dart';

@JsonSerializable()
class BifrostTokenData extends _BifrostTokenData {
  static BifrostTokenData fromJson(Map<String, dynamic> json) =>
      _$BifrostTokenDataFromJson(json);
  static Map<String, dynamic> toJson(BifrostTokenData info) =>
      _$BifrostTokenDataToJson(info);
}

abstract class _BifrostTokenData {
  String name;
  String symbol;
  String id;
  int precision;
  bool isBaseToken;
  bool isNetworkToken;
}

@JsonSerializable()
class BifrostBalanceData extends _BifrostBalanceData {
  static BifrostBalanceData fromJson(Map<String, dynamic> json) =>
      _$BifrostBalanceDataFromJson(json);
  static Map<String, dynamic> toJson(BifrostBalanceData info) =>
      _$BifrostBalanceDataToJson(info);
}

abstract class _BifrostBalanceData {
  String tokenId;
  String free;
}

@JsonSerializable()
class BifrostPriceData extends _BifrostPriceData {
  static BifrostPriceData fromJson(Map<String, dynamic> json) =>
      _$BifrostPriceDataFromJson(json);
  static Map<String, dynamic> toJson(BifrostPriceData info) =>
      _$BifrostPriceDataToJson(info);
}

abstract class _BifrostPriceData {
  String tokenId;
  String value;
  int timestamp;
}
