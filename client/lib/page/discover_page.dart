import 'package:flutter/material.dart';

import 'package:im/base/base_provider.dart';
import 'package:im/util/util.dart';
import 'package:im/provider/discover_provider.dart';
import 'package:provider/provider.dart';

class DiscoverPage extends PageProvideNode<DiscoverProvider> {
  @override
  Widget buildContent(BuildContext context) {
    return _DiscoverPage(mProvider: mProvider);
  }
}

class _DiscoverPage extends StatefulWidget {
  final DiscoverProvider mProvider;

  const _DiscoverPage({Key key, this.mProvider}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }

}

class ProfilePageState extends State<_DiscoverPage> {
  DiscoverProvider provider;

  @override
  void initState() {
    super.initState();
    provider = widget.mProvider;
  }

  void onClick(int index) {
    switch (index) {
      case 1:
      // Navigator.of(context).pushNamed(MRoutes.favorite);
        break;
      case 2:
      // Navigator.of(context).pushNamed(MRoutes.help);
        break;
      case 3:
      // Navigator.of(context).pushNamed(MRoutes.feedback);
        break;
      case 4:
      // Navigator.of(context).pushNamed(MRoutes.setting);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Util.colorBackgroudGrey(context),
      appBar: AppBar(
        backgroundColor: Util.colorLightWhite(context),
        title: Text(
          "发现",
          style: Util.appBarStyle(context),
        ),
      ),
      body: Consumer<DiscoverProvider>(
        builder: (context, value, child) {
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return Visibility(
                visible: index == 1 || index == 2 || index == 4,
                child: Divider(
                  color: Util.colorLine(context),
                  height: 1,
                ),
              );
            },
            itemCount: provider.datas.length,
            itemBuilder: (context, index) {
              var item = provider.datas[index];
              return _buildItem(index, item);
            },
          );
        },
      ),
    );
  }

  Widget _buildItem(int index, Map item) {
    return Container(
      margin: EdgeInsets.only(
          top: (index == 1 || index == 4) ? Util.setWidth(10) : 0),
      child: Ink(
        decoration: BoxDecoration(
          color: Util.colorItemGrey(context),
        ),
        child: InkWell(
          onTap: () => onClick(index),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: Util.setWidth(20), vertical: Util.setWidth(16)),
            child: Row(
              children: [
                Image(
                  image: Util.imageNamed(item["icon"]),
                  width: Util.setWidth(32),
                  height: Util.setWidth(32),
                  fit: BoxFit.cover,
                ),
                SizedBox(width: Util.setWidth(12)),
                Text(
                  item["name"],
                  style: TextStyle(
                      color: Util.color000(context), fontSize: Util.font14),
                ),
                Spacer(),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Util.color999,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
