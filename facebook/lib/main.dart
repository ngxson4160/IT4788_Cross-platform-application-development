import 'package:facebook/pages/home_page.dart';
import 'package:facebook/pages/login_page.dart';
import 'package:facebook/pages/post.dart';
import 'package:facebook/pages/register_page.dart';
import 'package:facebook/tabs/search.dart';
import 'package:facebook/values/api_values.dart';
// import 'package:facebook/pages/test.dart';
import 'package:facebook/widgets/element_friend.dart';
import 'package:facebook/widgets/request_friend_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final _storage = new FlutterSecureStorage();
Future<String?> getToken() async {
  return await _storage.read(key: "token");
}

void getTokenValue() async {
  ApiValues.TOKEN = await getToken();
}

Widget test() {
  if (ApiValues.TOKEN == null)
    return LoginPage();
  else
    return HomePage();
}

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: LoginPage(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getTokenValue();
  }

  @override
  Widget build(BuildContext context) {
    return test();
  }
}
