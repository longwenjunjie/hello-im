import 'package:flutter/material.dart';

import 'package:im/base/base_provider.dart';
import 'package:im/model/Session.dart';
import 'package:im/util/util.dart';
import 'package:im/provider/sessions_provider.dart';
import 'package:provider/provider.dart';

class SessionsPage extends PageProvideNode<SessionsProvider> {
  @override
  Widget buildContent(BuildContext context) {
    return _SessionPage(mProvider: mProvider);
  }
}

class _SessionPage extends StatefulWidget {
  final SessionsProvider mProvider;

  const _SessionPage({Key key, this.mProvider}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SessionPageState();
  }
}

class _SessionPageState extends State<_SessionPage> {
  SessionsProvider provide;

  @override
  void initState() {
    super.initState();
    provide = widget.mProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Util.colorBackgroudGrey(context),
      appBar: AppBar(
        backgroundColor: Util.colorLightWhite(context),
        title: Text(
          "消息",
          style: Util.appBarStyle(context),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: Util.setWidth(10)),
          _buildList(),
        ],
      ),
    );
  }

  Widget _buildList() {
    return Expanded(
      child: Consumer<SessionsProvider>(
        builder: (context, value, child) {
          return CustomScrollView(
            slivers: provide.datas.map((e) {
              return _buildListItem(e);
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildListItem(Session item) {
    return SliverToBoxAdapter(
        child: Ink(
      decoration: BoxDecoration(
        color: Util.colorItemGrey(context),
      ),
      child: InkWell(
        child: Container(
          height: Util.setWidth(72),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Util.colorLine(context), width: 1),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Image(
                  image: Util.imageNamed('icon_team.png'),
                  width: Util.setWidth(32),
                  height: Util.setWidth(32),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(item.name,
                            style: TextStyle(
                              fontSize: Util.font15,
                              color: Util.color000(context),
                            )),
                        Spacer(),
                        Container(
                          child: Text(
                            item.time,
                            style: TextStyle(
                              fontSize: Util.font14,
                              color: Util.color999,
                            ),
                          ),
                          margin: EdgeInsets.only(right: Util.setWidth(16)),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Util.setHeight(2)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              item.content,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: Util.font14, color: Util.color999),
                            ),
                          ),
                          Visibility(
                            visible: item.unreadCount > 0,
                            child: Container(
                              margin: EdgeInsets.only(right: 15),
                              width: 15,
                              height: 15,
                              decoration: new BoxDecoration(
                                border: new Border.all(
                                    color: Colors.red, width: 0.5),
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  item.unreadCount.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
