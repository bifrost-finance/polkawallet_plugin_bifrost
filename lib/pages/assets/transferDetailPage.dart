import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polkawallet_plugin_bifrost/api/types/transferData.dart';
import 'package:polkawallet_plugin_bifrost/polkawallet_plugin_bifrost.dart';
import 'package:polkawallet_plugin_bifrost/utils/i18n/index.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/utils/i18n.dart';
import 'package:polkawallet_ui/components/txDetail.dart';
import 'package:polkawallet_ui/utils/format.dart';

class TransferDetailPage extends StatelessWidget {
  TransferDetailPage(this.plugin, this.keyring);
  final PluginBifrost plugin;
  final Keyring keyring;

  static final String route = '/assets/token/tx';

  @override
  Widget build(BuildContext context) {
    final Map<String, String> dic =
        I18n.of(context).getDic(i18n_full_dic_bifrost, 'common');

    final TransferData tx = ModalRoute.of(context).settings.arguments;

    final String txType =
        tx.from == keyring.current.address ? dic['transfer'] : dic['receive'];

    String networkName = plugin.basic.name;

    return TxDetail(
      success: tx.isSuccess,
      action: txType,
      hash: tx.hash,
      blockTime: Fmt.dateTime(DateTime.parse(tx.timestamp)),
      networkName: networkName,
      infoItems: <TxDetailInfoItem>[
        TxDetailInfoItem(
          label: dic['amount'],
          content: Text(
            '${tx.amount} ${tx.token}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        TxDetailInfoItem(
          label: 'From',
          content: Text(Fmt.address(tx.from)),
          copyText: tx.from,
        ),
        TxDetailInfoItem(
          label: 'To',
          content: Text(Fmt.address(tx.to)),
          copyText: tx.to,
        )
      ],
    );
  }
}
