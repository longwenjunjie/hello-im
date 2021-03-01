import 'dart:async';
import 'dart:io';

import 'package:dartin/dartin.dart';
import 'package:dio/dio.dart';

import 'package:im/base/base_entity.dart';
import 'package:im/net/error_handle.dart';
import 'package:im/util/sp.dart';
import 'package:im/util/config.dart';
import 'package:im/util/event_bus.dart';
import 'package:im/util/toast.dart';

typedef SuccessCallback = void Function(dynamic json);
typedef ErrorCallback = void Function(int code, String reason);
typedef CompletionCallback = void Function();

enum Method { get, post, put, patch, delete, head }

extension MethodExtension on Method {
  String get value => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'][index];
}

var lastLogoutTipTime = new DateTime(2020, 1, 1, 1, 1);
var lastNetErrTipTime = new DateTime(2020, 1, 1, 1, 1);

/// 网络请求
final _dio = Dio()
  ..options = BaseOptions(
    baseUrl: Config.instance.baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    contentType:
        ContentType.parse("application/x-www-form-urlencoded").toString(),
    responseType: ResponseType.json,
  )
  // ..interceptors.add(CookieManager(CookieJar()))
  ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true))
  ..interceptors.add(
    InterceptorsWrapper(onRequest: (RequestOptions options) {
      return options;
    }, onResponse: (Response response) {
      return response;
    }),
  );

// 请求处理
Future _request(
  String method,
  String url, {
  dynamic data,
  Map<String, dynamic> queryParameters,
  CancelToken cancelToken,
  Options options,
}) {
  Completer completer = new Completer();
  _dio
      .request(url,
          data: data,
          queryParameters: queryParameters,
          options: _checkOptions(method, options),
          cancelToken: cancelToken)
      .then((response) {
    try {
      final data = response.data;
      BaseEntity result = BaseEntity.fromJson(data);
      if (result.code == 1) {
        if (result.data == null) {
          completer.complete();
        } else {
          completer.complete(result.data);
        }
      } else {
        completer
            .completeError(RequestError(result.code, result.message ?? "未知错误"));
      }
    } catch (e) {
      return BaseEntity(ErrorHandle.parse_error, '数据解析错误！', null);
    }
  }, onError: (dynamic e) {
    //TODO 会重复弹出 体验差 可改为在顶部固定显示错误信息
    if (e.response != null && e.response.statusCode == 401) {
      DateTime nowLogout = new DateTime.now();
      if (nowLogout.difference(lastLogoutTipTime).inSeconds > 30) {
        lastLogoutTipTime = nowLogout;
        Toast.show(msg: '登录信息过期，请重新登录');
        EventBus.instance.logout();
      }
      return;
    }

    //如果因为网络原因
    // if (e.response != null && e.response.statusCode != 401) {
    //   Toast.show(msg: '网络已断开');
    // }

    DateTime nowNetErr = new DateTime.now();
    if (nowNetErr.difference(lastNetErrTipTime).inSeconds > 3) {
      lastNetErrTipTime = nowNetErr;
      final RequestError error = ErrorHandle.handleException(e);
      // completer.completeError(error);
      Toast.show(msg: error.msg);
    }
  });

  return completer.future;
}

Options _checkOptions(String method, Options options) {
  options ??= Options();
  options.method = method;
  return options;
}

/// 网络请求-get
///
Stream get(String url, {Map<String, dynamic> params}) {
  return Stream.fromFuture(_request(
    Method.get.value,
    url,
    data: _parseParams(params),
  )).asBroadcastStream();
}

/// 网络请求-post
///
Stream post(String url, {Map<String, dynamic> params}) {
  return Stream.fromFuture(_request(
    Method.post.value,
    url,
    data: _parseParams(params),
  )).asBroadcastStream();
}

/// 网络请求-post
///
Stream upload(String url,
    {Map<String, dynamic> params,
    File file,
    String key = "image",
    String ext = ".jpg"}) {
  return Stream.fromFuture(_upload(url,
          params: _parseParams(params), file: file, key: key, ext: ext))
      .asBroadcastStream();
}

Future _upload(String url,
    {Map<String, dynamic> params, File file, String key, String ext}) async {
  String filename = DateTime.now().toString() + ext;
  params[key] = await MultipartFile.fromFile(
    file.path,
    filename: filename,
  );
  //print("上传图片" + params.toString());
  FormData formData = FormData.fromMap(params);
  return _request(
    "POST",
    url,
    data: formData,
  );
}

/// 网络请求-post
///
Stream uploads(String url, {List images, dynamic params}) {
  if (params != null) {
    return Stream.fromFuture(_uploadsDatas(url, images: images, params: params))
        .asBroadcastStream();
  } else {
    return Stream.fromFuture(_uploads(url, images: images)).asBroadcastStream();
  }
}

Future _uploadsDatas(String url, {List images, dynamic params}) async {
  List files = [];
  for (var item in images) {
    String filename = DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";
    files.add(await MultipartFile.fromFile(item.path, filename: filename));
  }
  params["image"] = files;

  Map data = _parseParams(params);
  //print("上传图片" + params.toString());
  FormData formData = FormData.fromMap(data);

  // FormData form = FormData();
  // Map data = _parseParams(params);
  // form.fields.addAll(data.entries);
  // for (int i = 0; i < images.length; i++) {
  //   var item = images[i];
  //   form.files.add(
  //     MapEntry(
  //       "image[]",
  //       MultipartFile.fromBytes(
  //         item.path,
  //         filename: '${DateTime.now().millisecondsSinceEpoch}.jpg',
  //       ),
  //     ),
  //   );
  // }
  return _request(
    Method.post.value,
    url,
    data: formData,
  );
}

Future<List> _uploads(String url, {List images}) async {
  List results = [];
  for (var item in images) {
    var response = await _upload(url,
        params: _parseParams(item["params"]),
        key: "image",
        ext: ".jpg",
        file: item["image"]);
    results.add(response);
  }
  return results;
}

Map<String, dynamic> _parseParams(Map<String, dynamic> params) {
  final sp = inject<SpUtil>();
  var token = sp.getString("token");

  //print("token = $token");
  if (token == null) {
    return params;
  } else if (params != null) {
    Map<String, dynamic> data = Map.from(params);
    data["token"] = token;
    return data;
  } else {
    return {"token": token};
  }
}
