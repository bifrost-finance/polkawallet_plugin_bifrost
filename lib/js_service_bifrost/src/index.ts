import "@babel/polyfill";
import { options } from "@bifrost-finance/api";
import { ApiPromise, WsProvider } from "@polkadot/api";
import { subscribeMessage, getNetworkConst, getNetworkProperties } from "./service/setting";
import { genLinks } from "./utils/config/config";
import keyring from "./service/keyring";
import account from "./service/account";

// send message to JSChannel: PolkaWallet
function send(path: string, data: any) {
  console.log(JSON.stringify({ path, data }));
}
send("log", "main js loaded");
(<any>window).send = send;

async function connect(nodes: string[]) {
  return new Promise(async (resolve, reject) => {
    const provider = new WsProvider(nodes);
    try {
      const res = new ApiPromise(options({ provider }));
      await res.isReady;

      (<any>window).api = res;
      const url = nodes[(<any>res)._options.provider.__private_9_endpointIndex];
      send("log", `${url} wss connected success`);
      resolve(url);
    } catch (err) {
      send("log", `connect failed`);
      provider.disconnect();
      resolve(null);
    }
  });
}

(<any>window).settings = {
  connect,
  getNetworkConst,
  getNetworkProperties,
  subscribeMessage,
  genLinks,
};

(<any>window).keyring = keyring;
(<any>window).account = account;
