import 'package:flutter/material.dart';

const int SECONDS_OF_DAY = 24 * 60 * 60; // seconds of one day
const int SECONDS_OF_YEAR = 365 * 24 * 60 * 60; // seconds of one year

const node_list = [
  {
    'name': 'OnFinality',
    'ss58': 6,
    'endpoint': 'wss://bifrost-parachain.api.onfinality.io/public-ws',
  },
  {
    'name': 'Patract Elara',
    'ss58': 6,
    'endpoint': 'wss://bifrost.kusama.elara.patract.io',
  },
];

const bifrost_token_ids = ["BNC", "KSM", "KUSD", "VSKSM", "VSBOND"];

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

const bifrost_token_decimals = 12;
const karura_stable_coin = 'KUSD';
const karura_stable_coin_view = 'kUSD';

final BigInt bifrostIntDivisor = BigInt.parse('1000000000000');

const bifrost_genesis_hash =
    '0xaa91d4910b841fb60aa13afbc1d18cd63525d82b1bbfe0e0c24b82a9ba949db1';
