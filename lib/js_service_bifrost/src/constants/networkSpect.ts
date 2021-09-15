const colors = {
  background: {
    app: "#151515",
    button: "C0C0C0",
    card: "#002cc3",
    os: "#000000"
  },
  border: {
    dark: "#000000",
    light: "#666666",
    signal: "#8E1F40"
  },
  signal: {
    error: "#D73400",
    main: "#FF4077"
  },
  text: {
    faded: "#9A9A9A",
    main: "#C0C0C0"
  }
};

export const unknownNetworkPathId = "";

export const NetworkProtocols = Object.freeze({
  SUBSTRATE: "substrate",
  UNKNOWN: "unknown"
});

// accounts for which the network couldn't be found (failed migration, removed network)
export const UnknownNetworkKeys = Object.freeze({
  UNKNOWN: "unknown"
});

/* eslint-enable sort-keys */

// genesisHash is used as Network key for Substrate networks
export const SubstrateNetworkKeys = Object.freeze({
  BIFROST: "0x9f28c6a68e0fc9646eff64935684f6eeeece527e37bbe1f213d22caa1d9d6bed"
});

const unknownNetworkBase = {
  [UnknownNetworkKeys.UNKNOWN]: {
    color: colors.signal.error,
    order: 99,
    pathId: unknownNetworkPathId,
    prefix: 2,
    protocol: NetworkProtocols.UNKNOWN,
    secondaryColor: colors.background.card,
    title: "Unknown network"
  }
};

const substrateNetworkBase = {
  [SubstrateNetworkKeys.BIFROST]: {
    color: "#9E3BFF",
    decimals: 12,
    genesisHash: SubstrateNetworkKeys.BIFROST,
    order: 4,
    pathId: "bifrost",
    prefix: 6,
    title: "Bifrost Mainnet",
    unit: "BNC"
  }
};

const substrateDefaultValues = {
  color: "#4C4646",
  protocol: NetworkProtocols.SUBSTRATE,
  secondaryColor: colors.background.card
};

function setDefault(networkBase, defaultProps) {
  return Object.keys(networkBase).reduce((acc, networkKey) => {
    return {
      ...acc,
      [networkKey]: {
        ...defaultProps,
        ...networkBase[networkKey]
      }
    };
  }, {});
}

export const SUBSTRATE_NETWORK_LIST = Object.freeze(
  setDefault(substrateNetworkBase, substrateDefaultValues)
);
export const UNKNOWN_NETWORK = Object.freeze(unknownNetworkBase);

const substrateNetworkMetas = Object.values({
  ...SUBSTRATE_NETWORK_LIST,
  ...UNKNOWN_NETWORK
});
export const PATH_IDS_LIST = substrateNetworkMetas.map(meta => meta.pathId);

export const NETWORK_LIST = Object.freeze(
  Object.assign({}, SUBSTRATE_NETWORK_LIST, [], UNKNOWN_NETWORK)
);
