///数据表定义

class CreateTableSqls {
  /// 消息表语句
  /// id 消息ID
  /// user_id 用户ID
  /// tag 消息标记
  /// from_id 发送者ID
  /// from_name 发送者昵称
  /// from_avatar 发送者头像
  /// to_id 接收者ID
  /// to_name 接收者昵称
  /// to_avatar 接收者头像
  /// typechat 聊天类型 100=单聊, 300=群聊
  /// typefile 消息类型 1=文字, 2=图片, 3=声音
  /// content 消息类型=文字，消息内容
  /// state_read 是否已读 0=否, 1=是
  static final String createMessageTableSql = '''
    CREATE TABLE IF NOT EXISTS message (
      id INTEGER NOT NULL, 
      user_id INTEGER NOT NULL,
      tag TEXT(50) NOT NULL, 
      from_id INTEGER NOT NULL, 
      from_name TEXT(32) NOT NULL,
      from_avatar TEXT(255) NOT NULL,
      to_id INTEGER NOT NULL, 
      to_name TEXT(32) NOT NULL,
      to_avatar TEXT(255) NOT NULL,
      typechat INTEGER NOT NULL,
      typefile TEXT(2) NOT NULL,
      content TEXT(1024),
      image TEXT,
      voice TEXT,
      video TEXT,
      state_read INTEGER NOT NULL,
      time INTEGER NOT NULL,
      sessionId INTEGER, 
      PRIMARY KEY(id, user_id)
    );
    ''';

  /// 会话表语句
  /// id 会话ID 单聊-对方ID, 群聊-群ID
  /// user_id 用户ID
  /// name 会话名称 单聊-对方昵称, 群聊-群名称
  /// avatar 头像 单聊-对方头像, 群聊-群LOGO
  /// typechat 聊天类型 100=单聊, 300=群聊
  /// content 最新消息
  /// stick 是否置顶 0=否, 1=是
  static final String createSessionTableSql = '''
    CREATE TABLE IF NOT EXISTS session (
      id INTEGER NOT NULL, 
      user_id INTEGER NOT NULL,
      name TEXT(32) NOT NULL,
      avatar TEXT(255) NOT NULL,
      typechat INTEGER NOT NULL,
      content TEXT(1024) NOT NULL,
      stick INTEGER NOT NULL,
      time INTEGER NOT NULL, 
      PRIMARY KEY(id, user_id)
    );
    ''';

  Map<String, String> getAllTables() {
    Map<String, String> map = Map<String, String>();
    map['message'] = createMessageTableSql;
    map['session'] = createSessionTableSql;
    return map;
  }
}
