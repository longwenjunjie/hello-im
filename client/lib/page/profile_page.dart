import 'package:flutter/material.dart';

import 'package:im/base/base_provider.dart';
import 'package:im/util/util.dart';
import 'package:im/provider/profile_provider.dart';

class ProfilePage extends PageProvideNode<ProfileProvider> {
  @override
  Widget buildContent(BuildContext context) {
    return _ProfilePage(mProvider: mProvider);
  }
}

class _ProfilePage extends StatelessWidget {
  final ProfileProvider mProvider;
  const _ProfilePage({Key key, this.mProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Util.colorLightWhite(context),
        title: Text(
          "我的",
          style: Util.appBarStyle(context),
        ),
      ),
      body: Container(
        color: Util.colorLightWhite(context),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                "我的",
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
