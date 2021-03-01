class BaseEntity {
  int code;
  String message;
  var data;

  BaseEntity(this.code, this.message, this.data);

  BaseEntity.fromJson(Map<String, dynamic> json) {
    code = json["code"] as int;
    message = json["msg"] as String;
    data = json["data"];
  }
}
