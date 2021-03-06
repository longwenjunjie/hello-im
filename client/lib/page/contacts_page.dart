import 'package:flutter/material.dart';

import 'package:im/base/base_provider.dart';
import 'package:im/model/friends_data.dart';
import 'package:im/util/util.dart';
import 'package:im/provider/contacts_provider.dart';
import 'package:im/widget/index_bar.dart';

class ContactsPage extends PageProvideNode<ContactsProvider> {
  @override
  Widget buildContent(BuildContext context) {
    return _ContactsPage(mProvider: mProvider);
  }
}

class _ContactsPage extends StatefulWidget {
  final ContactsProvider mProvider;

  const _ContactsPage({Key key, this.mProvider}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FriendsPageState();
  }
}

class FriendsPageState extends State<_ContactsPage> {
  ContactsProvider provider;

//  字典里面放item和高度的对应数据
  final Map _groupOffsetMap = {
//    这里因为根据实际数据变化和固定全部字母前两个值都是一样的，所以没有做动态修改，如果不一样记得要修改
    INDEX_WORDS[0]: 0.0,
    INDEX_WORDS[1]: 0.0,
  };

  ScrollController _scrollController;

  final List<Friends> _listDatas = [];

  @override
  void initState() {
    //初始化，只调用一次
    // TODO: implement initState
    super.initState();
    provider = widget.mProvider;

//    _listDatas.addAll(datas);
//    _listDatas.addAll(datas);
    //链式编程，等同于上面的两个
    _listDatas.clear();
    _listDatas.addAll(datas);
    // _listDatas..addAll(datas)..addAll(datas);

    //排序!
    _listDatas.sort((Friends a, Friends b) {
      return a.indexLetter.compareTo(b.indexLetter);
    });

    var _groupOffset = 54.5 * 2;
//经过循环计算，将每一个头的位置算出来，放入字典
    for (int i = 0; i < _listDatas.length; i++) {
      if (i < 1 || _listDatas[i].indexLetter != _listDatas[i - 1].indexLetter) {
        //第一个cell
        _groupOffsetMap.addAll({_listDatas[i].indexLetter: _groupOffset});
        //保存完了再加——groupOffset偏移
        _groupOffset += 84.5;
      } else {
//        if (_listDatas[i].indexLetter == _listDatas[i - 1].indexLetter) {
        //此时没有头部，只需要加偏移量就好了
        _groupOffset += 54.5;
      }
    }

    _scrollController = ScrollController();
  }

  final List<Friends> _headerData = [
    Friends(imageUrl: 'assets/images/icon_new_friend.png', name: '新的朋友'),
    Friends(imageUrl: 'assets/images/icon_team.png', name: '群聊'),
  ];

  Widget _itemForRow(BuildContext context, int index) {
//    系统cell
    if (index < _headerData.length) {
      return _FriendsCell(
        imageAssets: _headerData[index].imageUrl,
        name: _headerData[index].name,
      );
    }
    //显示剩下的cell
    //如果当前和上一个cell的indexLetter一样，就不显示
    bool _hideIndexLetter = (index - 2 > 0 &&
        _listDatas[index - 2].indexLetter == _listDatas[index - 3].indexLetter);
    return _FriendsCell(
      imageUrl: _listDatas[index - 2].imageUrl,
      name: _listDatas[index - 2].name,
      groupTitle: _hideIndexLetter ? null : _listDatas[index - 2].indexLetter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Util.colorLightWhite(context),
        title: Text(
          '通讯录',
          style: Util.appBarStyle(context),
        ),
        actions: <Widget>[
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Image(
                image: AssetImage('assets/images/icon_friends_add.png'),
                width: 25,
              ),
            ),
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => DiscoverChildPage(
              //       title: '添加朋友',
              //     )));
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
              color: Util.colorLightWhite(context),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _listDatas.length + _headerData.length,
                itemBuilder: _itemForRow,
              )), //列表
          IndexBar(
            indexBarCallBack: (String str) {
              if (_groupOffsetMap[str] != null) {
                _scrollController.animateTo(_groupOffsetMap[str],
                    duration: Duration(milliseconds: 1), curve: Curves.easeIn);
              }
            },
          ), //悬浮检索控件
        ],
      ),
    );
  }
}

class _FriendsCell extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String groupTitle;
  final String imageAssets;

  const _FriendsCell(
      {this.imageUrl, this.name, this.imageAssets, this.groupTitle}); //首字母大写

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10),
          height: groupTitle != null ? 30 : 0,
          color: Color.fromRGBO(1, 1, 1, 0.0),
          child: groupTitle != null
              ? Text(
                  groupTitle,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                )
              : null,
        ), //组头
        Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    image: DecorationImage(
                      image: imageUrl != null
                          ? NetworkImage(imageUrl)
                          : AssetImage(imageAssets),
                    )),
              ), //图片
              Container(
                child: Text(
                  name,
                  style: TextStyle(fontSize: 17),
                ),
              ), //昵称
            ],
          ),
        ), //通讯录组内容
        Container(
          height: 0.5,
          color: Util.colorLightWhite(context),
          child: Row(
            children: <Widget>[
              Container(
                width: 50,
                color: Colors.white,
              )
            ],
          ),
        ) //分割线
      ],
    );
  }
}
