import 'package:flutter/material.dart';
import 'package:polkawallet_plugin_bifrost/common/constants/base.dart';

const MaterialColor bifrost_jaco_blue = const MaterialColor(
  0xFF9E3BFF,
  const <int, Color>{
    50: const Color(0xFFE2F2FB),
    100: const Color(0xFFB6DFF5),
    200: const Color(0xFF85CAEF),
    300: const Color(0xFF54B5E9),
    400: const Color(0xFF2FA5E4),
    500: const Color(0xFF0A95DF),
    600: const Color(0xFF098DDB),
    700: const Color(0xFF0782D7),
    800: const Color(0xFF0578D2),
    900: const Color(0xFF0367CA),
  },
);

const bifrost_plugin_cache_key = 'plugin_bifrost';

final BigInt bifrostIntDivisor = BigInt.parse('1000000000000');

const bifrost_genesis_hash =
    '0xaa91d4910b841fb60aa13afbc1d18cd63525d82b1bbfe0e0c24b82a9ba949db1';

const bifrost_token_decimals = 12;
const karura_stable_coin = 'KUSD';
const karura_stable_coin_view = 'kUSD';

const relay_chain_token_symbol = 'KSM';
const relay_chain_name = 'kusama';

const network_ss58_format = {
  plugin_name_bifrost: 6,
  'kusama': 2,
};

const relay_chain_xcm_fees = {
  // todo: polkadot xcm not enabled
  // 'polkadot': {
  //   'fee': '3000000000',
  //   'existentialDeposit': '1000000000',
  // },
  'kusama': {
    'fee': '79999999',
    'existentialDeposit': '33333333',
  },
};
const xcm_dest_weight = '4000000000';

const bifrost_token_ids = [
  "BNC",
  "KAR",
  "KSM",
  "KUSD",
  "ZLK",
  "VSDOT",
  "VSKSM",
  "VSBOND"
];
