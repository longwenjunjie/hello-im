import 'package:flutter/material.dart';

import 'package:im/base/base_provider.dart';
import 'package:im/util/util.dart';
import 'package:im/provider/sessions_provider.dart';

class SessionsPage extends PageProvideNode<SessionsProvider> {
  @override
  Widget buildContent(BuildContext context) {
    return _SessionPage(mProvider: mProvider);
  }
}

class _SessionPage extends StatelessWidget {
  final SessionsProvider mProvider;
  const _SessionPage({Key key, this.mProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Util.colorLightWhite(context),
        title: Text(
          "会话",
          style: Util.appBarStyle(context),
        ),
      ),
      body: Container(
        color: Util.colorLightWhite(context),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                "会话",
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
