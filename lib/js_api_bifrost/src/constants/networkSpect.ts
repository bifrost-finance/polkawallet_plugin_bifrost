const colors = {
    background: {
        app: "#151515",
        button: "C0C0C0",
        card: "#262626",
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

export const NetworkProtocols = Object.freeze({
    ETHEREUM: "ethereum",
    SUBSTRATE: "substrate",
    UNKNOWN: "unknown"
});

// genesisHash is used as Network key for Substrate networks
export const SubstrateNetworkKeys = Object.freeze({
    BIFROST:
        "0xaa91d4910b841fb60aa13afbc1d18cd63525d82b1bbfe0e0c24b82a9ba949db1"
});

const substrateNetworkBase = {
    [SubstrateNetworkKeys.BIFROST]: {
        color: "#002cc3",
        decimals: 12,
        genesisHash: SubstrateNetworkKeys.BIFROST,
        order: 4,
        pathId: "bifrost",
        prefix: 6,
        title: "Bifrost Asgard CC4",
        unit: "ASG"
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
