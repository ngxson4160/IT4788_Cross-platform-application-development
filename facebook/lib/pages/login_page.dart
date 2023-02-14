import 'dart:async';
import 'dart:convert';
import 'package:facebook/pages/home_page.dart';
import 'package:facebook/pages/register_page.dart';
import 'package:facebook/values/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';
// import 'friend_page.dart';
import 'package:http/http.dart' as http;
import '../values/api_values.dart';
import '../widgets/element_friend.dart';
import '../widgets/upload.dart';

// import 'package:facebook/services/remote_service.dart';

class LoginPage extends StatelessWidget {
  // ignore: avoid_types_as_parameter_names
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(children: [
      Image.asset("assets/images/background.jpg"),
      Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.03),
        child: const Text.rich(TextSpan(
            text: 'Afrikaans ● Francais ● ',
            children: <TextSpan>[
              TextSpan(text: 'More...', style: TextStyle(color: AppColors.blue))
            ])),
      ),
      Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.06,
              left: screenWidth * 0.1,
              right: screenWidth * 0.1),
          child: Column(children: [
            TextFormField(
                decoration:
                    const InputDecoration(hintText: "Số điện thoại hoặc email"),
                keyboardType: TextInputType.number,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SubLoginPage()));
                }),
            TextFormField(
                obscureText: true,
                obscuringCharacter: "•",
                decoration: const InputDecoration(hintText: "Mật khẩu"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SubLoginPage()));
                  // FocusScope.of(context).requestFocus(_focusNode);
                }),
            Container(
                margin: const EdgeInsets.only(top: 30),
                height: screenHeight * 0.055,
                width: screenWidth,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue),
                    child: const Text("Đăng nhập",
                        style: TextStyle(
                            color: AppColors.lightBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)))),
            // ignore: prefer_const_constructors
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: const Text("Quên mật khẩu?",
                    style: TextStyle(
                        color: AppColors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold))),
            // ignore: prefer_const_constructors
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: const Text("------HOẶC------",
                    style: TextStyle(color: AppColors.gray))),
            Container(
                margin: const EdgeInsets.only(top: 30),
                height: screenHeight * 0.055,
                width: screenWidth * 0.65,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green),
                    // ignore: prefer_const_constructors
                    child: Text("Tạo tài khoản Facebook mới",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)))),
          ]))
    ]));
  }
}

class SubLoginPage extends StatefulWidget {
  const SubLoginPage({super.key});

  @override
  State<SubLoginPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SubLoginPage> {
  bool _showPass = false;
  bool _filedPassword = false;
  bool _filedPhoneNumber = false;
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  String? _codeLogin;
  String? _message;
  bool _isLogined = false;
  Future<List<User>>? _login;
  @override
  void initState() {
    super.initState();
  }

  final _storage = new FlutterSecureStorage();
  void storeUserName(String data) async {
    await _storage.write(key: "userName", value: data);
  }

  void storeToken(String data) async {
    await _storage.write(key: "token", value: data);
  }

  void storeId(String data) async {
    await _storage.write(key: "id", value: data);
  }

  void storeAvatar(String data) async {
    await _storage.write(key: "avatar", value: data);
  }

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

  // void getData() async {
  //   ApiValues.USERNAME = await getUserName();
  //   ApiValues.TOKEN = await getToken();
  //   ApiValues.ID = await getId();
  //   ApiValues.AVATAR = await getAvatar();
  // }

  Future<void> login(String phonenumber, String password) async {
    final response = await http.post(
      Uri.parse(
          "https://flutter-hust.onrender.com/it4788/auth/login?phonenumber=${phonenumber}&password=${password}"),
      body: jsonEncode(<String, String>{
        'phonenumber': phonenumber,
        'password': password,
      }),
    );
    final data = json.decode(response.body);
    _message = data['message'];
    if (response.statusCode == 200) {
      storeUserName(data['data']['username']);
      storeToken(data['data']['token']);
      storeId(data['data']['id']);
      storeAvatar(data['data']['avatar']);
      ApiValues.AVATAR = data['data']['avatar'];
      ApiValues.TOKEN = data['data']['token'];
      ApiValues.ID = data['data']['id'];
      ApiValues.USERNAME = data['data']['username'];
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(children: [
      Padding(
        padding: EdgeInsets.only(
            top: screenHeight * 0.05,
            left: screenWidth * 0.42,
            right: screenWidth * 0.42),
        child: Image.asset("assets/images/logoFacebook.png"),
      ),
      Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.05,
              left: screenWidth * 0.1,
              right: screenWidth * 0.1),
          child: Column(children: [
            TextFormField(
              controller: phone,
              decoration:
                  const InputDecoration(hintText: "Số điện thoại hoặc email"),
              keyboardType: TextInputType.number,
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    _filedPhoneNumber = true;
                  }
                  if (value.isEmpty) {
                    _filedPhoneNumber = false;
                  }
                });
              },
            ),
            Stack(alignment: AlignmentDirectional.centerEnd, children: [
              TextFormField(
                controller: pass,
                obscureText: !_showPass,
                obscuringCharacter: "•",
                onChanged: (value) {
                  Timer.periodic(Duration(milliseconds: 50), (timer) {
                    setState(() {
                      if (value.isNotEmpty) {
                        _filedPassword = true;
                      }
                      if (value.isEmpty) {
                        _filedPassword = false;
                      }
                    });
                  });
                },
                decoration: const InputDecoration(hintText: "Mật khẩu"),
              ),
              GestureDetector(
                child: Text(_filedPassword ? "HIỂN THỊ" : "",
                    style: TextStyle(color: Colors.grey, fontSize: 14)),
                onTap: onToggleChangePass,
              )
            ]),
            SizedBox(height: 20),
            Container(
              height: 13,
              child: Visibility(
                visible: (_isLogined && _message != null),
                child: Text(_message.toString(),
                    style: TextStyle(color: AppColors.red)),
              ),
            ),
            Container(
              height: 20,
              child: Visibility(
                  visible: (_isLogined && _message == null),
                  child: Container(
                    height: 20,
                    width: 20,
                    child: Center(child: CircularProgressIndicator()),
                  )),
            ),
            Container(
                margin: const EdgeInsets.only(top: 10),
                height: screenHeight * 0.055,
                width: screenWidth,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // storeUSERNAME();
                        _isLogined = true;
                        login(phone.text.toString(), pass.text.toString());
                        getData();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue),
                    child: Text("Đăng nhập",
                        style: TextStyle(
                            color: (_filedPassword && _filedPhoneNumber)
                                ? AppColors.white
                                : AppColors.lightBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)))),
            const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text("Quên mật khẩu?",
                    style: TextStyle(
                        color: AppColors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold))),
          ]))
    ]));
  }

  void onToggleChangePass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
