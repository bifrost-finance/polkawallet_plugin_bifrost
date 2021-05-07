import "@babel/polyfill";
import { ApiPromise, WsProvider } from "@polkadot/api";
import jsonrpc from "@polkadot/types/interfaces/jsonrpc";
import { options } from "@bifrost-finance/api";
import {
    getNetworkConst,
    getNetworkProperties,
    subscribeMessage
} from "./service/setting";
import keyring from "./service/keyring";
import account from "./service/account";
import { genLinks } from "./utils/config/config";
import * as types from "./developer_setting.json";

// send message to JSChannel: PolkaWallet
function send(path: string, data: any) {
    if (window.location.href.match("https://localhost:8080/")) {
        PolkaWallet.postMessage(JSON.stringify({ path, data }));
    } else {
        console.log(path, data);
    }
}

send("log", "main js loaded");
(<any>window).send = send;

/**
 * connect to a specific node.
 *
 * @param {string} nodeEndpoint
 */
async function connect(nodes: string[]) {
    return new Promise(async (resolve, reject) => {
        const wsProvider = new WsProvider(nodes);
        try {
            const res = await ApiPromise.create(
                options({ provider: wsProvider, types, rpc: jsonrpc })
            );
            await res.isReady;
            (<any>window).api = res;
            const url =
                nodes[(<any>res)._options.provider.__private_9_endpointIndex];
            send("log", `${url} wss connected success ${url}`);
            resolve(url);
        } catch (err) {
            send("log", `connect failed`);
            wsProvider.disconnect();
            resolve(null);
        }
    });
}

const settings = {
    connect,
    subscribeMessage,
    getNetworkConst,
    getNetworkProperties,
    genLinks
};

(<any>window).settings = settings;
(<any>window).keyring = keyring;
(<any>window).account = account;

export default settings;
