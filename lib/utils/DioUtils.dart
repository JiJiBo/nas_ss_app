import 'package:dio/dio.dart';
import 'package:nas_ss_app/mf.dart';

import '../mobx/route.dart';

String get url {
  return "https://${routeStore.url}${routeStore.port.isEmpty ? "" : ":" + routeStore.port}";
}

// const url = "http://192.168.1.10:28000";
var dio = Dio();

Future<String> getRoot() async {
  return Future.value(url);
}

Future<Response<Map>> add_novel(String name, link, voice, background_music,
    voice_id, background_music_id) async {
  String path = await getRoot() + "/add_novel";
  if (!link.endsWith("/")) {
    link = link + "/";
  }
  Map<String, dynamic> parameters = {
    "name": name,
    "voice": voice,
    "voice_id": voice_id,
    "user_id": "id".getString(defaultValue: ""),
    "background_music": background_music,
    "background_music_id": background_music_id,
    "link": link
  };
  print(parameters);
  Response<Map> query = await dio.post(
    path,
    data: parameters,
    options: getOptions(),
  );
  return query;
}

Future<Response<Map>> add_novel_by_txt(
    String name,
    String filePath,
    String voice,
    String backgroundMusic,
    String voiceId,
    String backgroundMusicId) async {
  String path = await getRoot() + "/add_novel_by_txt";
  Map<String, dynamic> parameters = {
    "name": name,
    "voice": voice,
    "voice_id": voiceId,
    "user_id": "id".getString(defaultValue: ""),
    "background_music": backgroundMusic,
    "background_music_id": backgroundMusicId,
  };

  // 创建FormData
  FormData formData = FormData.fromMap({
    ...parameters,
    // 其他参数
    "novel_file": await MultipartFile.fromFile(filePath, filename: "novel.txt")
    // 文件参数
  });

  print(parameters);
  Response<Map> response = await dio.post(
    path,
    data: formData, // 使用FormData作为请求体
    options: Options(headers: {
      'Content-Type': 'multipart/form-data',
      // 更改Content-Type为multipart/form-data
    }),
  );
  return response;
}

Future<Response<Map>> login(String name, password) async {
  String path = await getRoot() + "/login";
  Map<String, dynamic> parameters = {"name": name, "password": password};
  print(parameters);
  Response<Map> query = await dio.post(
    path,
    data: parameters,
    options: getOptions(),
  );
  return query;
}

Future<Response<Map>> register(String name, password) async {
  String path = await getRoot() + "/register";
  Map<String, dynamic> parameters = {"name": name, "password": password};
  print(parameters);
  Response<Map> query = await dio.post(
    path,
    data: parameters,
    options: getOptions(),
  );
  return query;
}

Future<Response<Map>> get_all_voice() async {
  String path = await getRoot() + "/get_all_voice";

  Response<Map> query = await dio.get(
    path,
  );
  return query;
}

Future<Response<Map>> get_all_bgm() async {
  String path = await getRoot() + "/get_all_bgm";

  Response<Map> query = await dio.get(
    path,
  );
  return query;
}

Future<Response<Map>> get_all_novels(page) async {
  String path = await getRoot() + "/get_all_novels";
  Map<String, dynamic> parameters = {
    "page": page,
    "user_id": "id".getString(defaultValue: "-1"),
  };
  print(path);
  Response<Map> query = await dio.get(path, queryParameters: parameters);
  return query;
}

Future<Response<Map>> get_filtered_books(page, book_id, get_step) async {
  String path = await getRoot() + "/get_filtered_books";
  Map<String, dynamic> parameters = {
    "page": page,
    "get_step": get_step,
    "book_id": book_id,
  };
  Response<Map> query = await dio.get(path, queryParameters: parameters);
  return query;
}

Future<Response<Map>> get_novel(novel_id) async {
  String path = await getRoot() + "/get_novel";
  Map<String, dynamic> parameters = {
    "novel_id": novel_id,
  };
  Response<Map> query = await dio.get(path, queryParameters: parameters);
  return query;
}

Future<Response<Map>> update_novel(novel_id) async {
  String path = await getRoot() + "/update_novel";
  Map<String, dynamic> parameters = {
    "novel_id": novel_id,
  };
  Response<Map> query = await dio.get(path, queryParameters: parameters);
  return query;
}

Future<Response<Map>> delete_novel(novel_id) async {
  String path = await getRoot() + "/delete_novel";
  Map<String, dynamic> parameters = {
    "novel_id": novel_id,
  };
  Response<Map> query = await dio.get(path, queryParameters: parameters);
  return query;
}

Future<Response<Map>> stop_novel(novel_id) async {
  String path = await getRoot() + "/stop_novel";
  Map<String, dynamic> parameters = {
    "novel_id": novel_id,
  };
  Response<Map> query = await dio.get(path, queryParameters: parameters);
  return query;
}

Future<Response<Map>> clear_novel(novel_id) async {
  String path = await getRoot() + "/clear_novel";
  Map<String, dynamic> parameters = {
    "novel_id": novel_id,
  };
  Response<Map> query = await dio.get(path, queryParameters: parameters);
  return query;
}

Future<Response<Map>> get_a_bgm(bgm_id) async {
  String path = await getRoot() + "/get_a_bgm";
  Map<String, dynamic> parameters = {
    "bgm_id": bgm_id,
  };
  Response<Map> query = await dio.get(path, queryParameters: parameters);
  return query;
}

Future<Response<Map>> get_a_voice(voice_id) async {
  String path = await getRoot() + "/get_a_voice";
  Map<String, dynamic> parameters = {
    "voice_id": voice_id,
  };
  Response<Map> query = await dio.get(path, queryParameters: parameters);
  return query;
}

Options getOptions() => Options( );
