import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'package:im/util/util.dart';
import 'package:im/util/double_tap_exit.dart';

import 'package:im/page/sessions_page.dart';
import 'package:im/page/contacts_page.dart';
import 'package:im/page/discover_page.dart';
import 'package:im/page/profile_page.dart';

import 'package:im/base/base_provider.dart';
import 'package:im/provider/main_provider.dart';

class MainPage extends PageProvideNode<MainProvider> {
  @override
  Widget buildContent(BuildContext context) {
    return _MainPage(mProvider: mProvider);
  }
}

class _MainPage extends StatefulWidget {
  final MainProvider mProvider;

  const _MainPage({Key key, this.mProvider}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<_MainPage> {
  MainProvider provide;

  int _tabIndex = 0;

  final List _pageList = [
    SessionsPage(),
    ContactsPage(),
    DiscoverPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    provide = widget.mProvider;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(360, 640));
    return Scaffold(
      body: DoubleTapExit(
        child: _pageList[_tabIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
                size: 24,
              ),
              label: "消息"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.contacts,
                size: 24,
              ),
              label: "联系人"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.ac_unit,
                size: 24,
              ),
              label: "发现"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 24,
              ),
              label: "我的"),
        ],
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Util.color999,
        selectedItemColor: Colors.lightBlue,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }
}
