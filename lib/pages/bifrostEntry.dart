import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polkawallet_plugin_bifrost/pages/gov/democracyPage.dart';
import 'package:polkawallet_plugin_bifrost/polkawallet_plugin_bifrost.dart';
import 'package:polkawallet_plugin_bifrost/utils/i18n/index.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/utils/i18n.dart';
import 'package:polkawallet_ui/components/entryPageCard.dart';

class BifrostEntry extends StatefulWidget {
  BifrostEntry(this.plugin, this.keyring);

  final PluginBifrost plugin;
  final Keyring keyring;

  @override
  _BifrostEntryState createState() => _BifrostEntryState();
}

class _BifrostEntryState extends State<BifrostEntry> {
  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context).getDic(i18n_full_dic_bifrost, 'common');
    final dicGov = I18n.of(context).getDic(i18n_full_dic_bifrost, 'gov');

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    dic['bifrost'],
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).cardColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Observer(
                builder: (_) {
                  if (widget.plugin.sdk.api?.connectedNode == null) {
                    return Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 2),
                      child: Column(
                        children: [
                          CupertinoActivityIndicator(),
                          Text(dic['node.connecting']),
                        ],
                      ),
                    );
                  }

                  return ListView(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          child: EntryPageCard(
                            dicGov['democracy'],
                            dicGov['democracy.brief'],
                            SvgPicture.asset(
                              'packages/polkawallet_plugin_bifrost/assets/images/democracy.svg',
                              height: 88,
                              color: Theme.of(context).primaryColor,
                            ),
                            color: Colors.transparent,
                          ),
                          onTap: () => Navigator.of(context)
                              .pushNamed(DemocracyPage.route),
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
