import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:im/util/global.dart';

typedef void EventCallback(arg);

class EventBus {
  // 工厂模式
  factory EventBus() => _getInstance();

  static EventBus get instance => _getInstance();
  static EventBus _instance;

  // static AudioCache _player = AudioCache();
  static String _sessionId = '';

  EventBus._internal() {
    // 初始化
  }

  static EventBus _getInstance() {
    if (_instance == null) {
      _instance = new EventBus._internal();
    }
    return _instance;
  }

  BuildContext _context;
  // 添加一个全局刷新
  void addTabbarRefreshNoti(BuildContext context) {
    _context = context;
  }

  // void refreshUnread() {
  //   Provider.of<MainProvide>(_context, listen: false).getUnread();
  // }

  void enterChat(sessionId) {
    _sessionId = sessionId;
  }

  void leaveChat(sessionId) {
    _sessionId = '';
  }

  void notify(String sessionId, Map message) async {
    if (_sessionId != sessionId) {
      // _player.play('notify.mp3');

      String type = message['typefile'].toString();
      String content;
      if (type == '1') {
        content = message['content'];
      } else if (type == '2') {
        content = '[图片]';
      } else if (type == '3') {
        content = '[语音]';
      } else if (type == '6') {
        content = message['content'];
      } else if (type == '8') {
        content = '[视频]';
      } else {
        return;
      }

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'hello_im_channel', 'hello im channel', 'Hello IM通知',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
      const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
      await Global.instance.flutterLocalNotificationsPlugin.show(
          0, '新消息', content, platformChannelSpecifics, payload: 'item x');
    }
  }

  void logout() {
    Global.instance.onLogout();
  }

  //保存事件订阅者队列，key:事件名(id)，value: 对应事件的订阅者队列
  var _emap = new Map<Object, List<EventCallback>>();

  //添加订阅者
  void on(eventName, EventCallback f) {
    if (eventName == null || f == null) return;
    _emap[eventName] ??= new List<EventCallback>();
    _emap[eventName].add(f);
  }

  //移除订阅者
  void off(eventName, [EventCallback f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) return;
    if (f == null) {
      _emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  /// 触发事件，事件触发后该事件所有订阅者会被调用
  /// event_refresh_session_list
  /// event_new_message
  /// event_unread_refresh
  /// event_connect_lost
  /// event_team_delete -- 患者端无用
  /// event_refresh_unverify_list -- 患者端无用
  /// event_register_success
  /// event_new_doctor_msg
  /// event_new_system_msg
  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) return;
    int len = list.length - 1;
    //反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}
