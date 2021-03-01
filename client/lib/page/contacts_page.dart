import 'package:flutter/material.dart';

import 'package:im/base/base_provider.dart';
import 'package:im/util/util.dart';
import 'package:im/provider/contacts_provider.dart';

class ContactsPage extends PageProvideNode<ContactsProvider> {
  @override
  Widget buildContent(BuildContext context) {
    return _SessionPage(mProvider: mProvider);
  }
}

class _SessionPage extends StatelessWidget {
  final ContactsProvider mProvider;
  const _SessionPage({Key key, this.mProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Util.colorLightWhite(context),
        title: Text(
          "联系人",
          style: Util.appBarStyle(context),
        ),
      ),
      body: Container(
        color: Util.colorLightWhite(context),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                "联系人",
                style: TextStyle(
                  color: Util.color000(context),
                  height: 1.8,
                  fontSize: Util.font15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
