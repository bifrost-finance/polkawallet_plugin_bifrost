import 'package:polkawallet_plugin_bifrost/api/bifrostService.dart';
import 'package:polkawallet_plugin_bifrost/api/assets/bifrostApiAssets.dart';

class BifrostApi {
  BifrostApi(BifrostService service)
      : assets = BifrostApiAssets(service.assets);

  final BifrostApiAssets assets;
}
