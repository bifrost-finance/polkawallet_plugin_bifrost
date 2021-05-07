import 'package:flutter/material.dart';

const int SECONDS_OF_DAY = 24 * 60 * 60; // seconds of one day
const int SECONDS_OF_YEAR = 365 * 24 * 60 * 60; // seconds of one year

const node_list_bifrost = [
  {
    'name': 'Bifrost Mainnet #1 (hosted by Commonwealth Labs)',
    'ss58': 6,
    'endpoint': 'wss://asgard-rpc.liebi.com/ws/',
  },
];

const MaterialColor bifrost_jaco_blue = const MaterialColor(
  0xFF0A95DF,
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

const home_nav_items = [];

const String genesis_hash_bifrost =
    '0xaa91d4910b841fb60aa13afbc1d18cd63525d82b1bbfe0e0c24b82a9ba949db1';
const String network_name_bifrost = 'liebi';
