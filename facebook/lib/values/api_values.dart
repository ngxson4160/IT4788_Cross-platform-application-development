import 'dart:convert';

import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// final _storage = new FlutterSecureStorage();
// Future<String?> getUserName() async {
//   return await _storage.read(key: "userName");
// }

// Future<String?> getToken() async {
//   return await _storage.read(key: "token");
// }

// Future<String?> getId() async {
//   return await _storage.read(key: "id");
// }

// Future<String?> getAvatar() async {
//   return await _storage.read(key: "avatar");
// }

// Future<void> getData() async {
//   ApiValues.USERNAME = await getUserName();
//   ApiValues.TOKEN = await getToken();
//   ApiValues.ID = await getId();
//   ApiValues.AVATAR = await getAvatar();
// }

Future<String?> getInfo(String token, String id) async {
  String isFriend = "", code = "";
  final response = await http.post(
    Uri.parse(
        "https://flutter-hust.onrender.com/it4788/user/get_user_info?token=${token}&user_id=${id}"),
    body: jsonEncode(<String, String>{
      'token': token,
      'user_id': id,
    }),
  );
  final data = json.decode(response.body);
  if (response.statusCode == 200) {
    isFriend = data['data']['is_friend'];
    code = data['code'];
  }
  if (response.statusCode == 401) {
    code = "9995";
  }
  if (code == "9995")
    return "blocked";
  else
    return isFriend;
}

class ApiValues {
  static String? AVATAR;
  static String? TOKEN;
  static String? USERNAME;

  static String? ID;
}
