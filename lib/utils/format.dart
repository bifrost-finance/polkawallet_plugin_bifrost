import 'package:polkawallet_plugin_bifrost/common/constants.dart';

class PluginFmt {
  static String tokenView(String token) {
    String tokenView = token ?? '';
    if (token == karura_stable_coin) {
      tokenView = karura_stable_coin_view;
    }
    return tokenView;
  }
}
