import 'package:flutter/material.dart';

import 'package:im/base/base_provider.dart';
import 'package:im/util/util.dart';
import 'package:im/provider/discover_provider.dart';

class DiscoverPage extends PageProvideNode<DiscoverProvider> {
  @override
  Widget buildContent(BuildContext context) {
    return _DiscoverPage(mProvider: mProvider);
  }
}

class _DiscoverPage extends StatelessWidget {
  final DiscoverProvider mProvider;
  const _DiscoverPage({Key key, this.mProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Util.colorLightWhite(context),
        title: Text(
          "发现",
          style: Util.appBarStyle(context),
        ),
      ),
      body: Container(
        color: Util.colorLightWhite(context),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                "发现",
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
