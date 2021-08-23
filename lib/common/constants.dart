const int SECONDS_OF_DAY = 24 * 60 * 60; // seconds of one day
const int SECONDS_OF_YEAR = 365 * 24 * 60 * 60; // seconds of one year

const node_list = [
  {
    'name': 'Liebi',
    'ss58': 6,
    'endpoint': 'wss://bifrost-rpc.liebi.com/ws',
  },
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

const bifrost_plugin_cache_key = 'plugin_bifrost';

const bifrost_token_decimals = 12;
const karura_stable_coin = 'KUSD';
const karura_stable_coin_view = 'kUSD';

final BigInt bifrostIntDivisor = BigInt.parse('1000000000000');

const bifrost_genesis_hash =
    '0xaa91d4910b841fb60aa13afbc1d18cd63525d82b1bbfe0e0c24b82a9ba949db1';
