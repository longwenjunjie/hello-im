import 'package:flutter/material.dart';

import 'package:im/base/base_provider.dart';
import 'package:im/model/user.dart';
import 'package:im/util/network_image_util.dart';
import 'package:im/util/util.dart';
import 'package:im/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends PageProvideNode<ProfileProvider> {
  @override
  Widget buildContent(BuildContext context) {
    return _ProfilePage(mProvider: mProvider);
  }
}

class _ProfilePage extends StatefulWidget {
  final ProfileProvider mProvider;

  const _ProfilePage({Key key, this.mProvider}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }

}

class ProfilePageState extends State<_ProfilePage> {
  ProfileProvider provider;

  @override
  void initState() {
    super.initState();
    provider = widget.mProvider;
  }

  void showUserInfo() {
    // Navigator.of(context).pushNamed(MRoutes.userinfo).then((value) {
    //   if (Global.instance.needUpdate) {
    //     provide.changeDatas();
    //     Global.instance.needUpdate = false;
    //   }
    // });
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
      case 5:
        // Navigator.of(context).pushNamed(MRoutes.about);
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
          "我的",
          style: Util.appBarStyle(context),
        ),
      ),
      body: Consumer<ProfileProvider>(
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
              if (index == 0) {
                return _buildUserInfo(item);
              } else {
                return _buildItem(index, item);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildUserInfo(User user) {
    return GestureDetector(
      onTap: showUserInfo,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: Util.setHeight(12), horizontal: Util.setWidth(20)),
        color: Util.colorItemGrey(context),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: NetworkImageUtil.assetNetwork(
                image: user.avatar,
                width: Util.setWidth(44),
                height: Util.setWidth(44),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: Util.setWidth(20)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                            fontSize: Util.font16,
                            color: Util.color000(context)),
                      ),
                      SizedBox(width: Util.setWidth(5)),
                      Text(
                        "(男)",
                        style: TextStyle(
                          fontSize: Util.font14,
                          color: Util.color999,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "电话：18800000001",
                    style:
                        TextStyle(fontSize: Util.font14, color: Util.color999),
                  ),
                ],
              ),
            ),
            SizedBox(width: Util.setWidth(4)),
            Icon(
              Icons.keyboard_arrow_right,
              color: Util.color999,
            )
          ],
        ),
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
