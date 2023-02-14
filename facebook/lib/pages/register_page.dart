import 'dart:convert';

import 'package:facebook/values/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import '../models/Register.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'package:http/http.dart' as http;

String? _fullName;
String? _phoneNumber;
String? _password;
String _messagePhone =
    "Nhập số di động để liên hệ của bạn. Bạn có thể ẩn thông tin này trên trang cá nhân sau.";

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _NameState();
}

class _NameState extends State<RegisterPage> {
  bool _filledFamilyName = false;
  bool _filedName = false;
  String _textMessage = "Nhập tên bạn sử dụng trong đời thực.";
  Color _colorMessage = AppColors.gray;

  TextEditingController _familyName = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("Tên",
              style: TextStyle(
                color: AppColors.black,
              )),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: AppColors.black,
            onPressed: () {
              showAlertDialog(context);
            },
          ),
          backgroundColor: AppColors.white,
        ),
        body: Column(children: [
          Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.045),
              child: Text("Tên bạn là gì?",
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold))),
          Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.025),
              child: Text(_textMessage,
                  style: TextStyle(
                    color: _colorMessage,
                    fontSize: 18,
                  ))),
          Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.03,
                left: screenWidth * 0.05,
                right: screenWidth * 0.05),
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 30),
                    height: screenHeight * 0.075,
                    width: screenWidth,
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth * 0.44,
                          child: Padding(
                              padding: EdgeInsets.only(left: screenWidth * 0),
                              child: TextFormField(
                                controller: _familyName,
                                decoration: const InputDecoration(
                                  hintText: "Họ",
                                  labelText: "Họ",
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    _filledFamilyName = true;
                                  } else {
                                    _filledFamilyName = false;
                                  }
                                },
                              )),
                        ),
                        Container(
                          width: screenWidth * 0.44,
                          child: Padding(
                              padding:
                                  EdgeInsets.only(left: screenWidth * 0.02),
                              child: TextFormField(
                                controller: _name,
                                decoration: const InputDecoration(
                                  hintText: "Tên",
                                  labelText: "Tên",
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    _filedName = true;
                                  } else {
                                    _filedName = false;
                                  }
                                },
                              )),
                        ),
                      ],
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 30),
                    height: screenHeight * 0.055,
                    width: screenWidth,
                    child: ElevatedButton(
                        onPressed: () {
                          checkInput();
                          if (_colorMessage == AppColors.red) return;
                          _fullName = _familyName.text.toString() +
                              " " +
                              _name.text.toString();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DateOfBirth()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue),
                        child: const Text("Tiếp",
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold))))
              ],
            ),
          ),
        ]));
  }

  void checkInput() {
    setState(() {
      if (!_filedName && !_filledFamilyName) {
        _textMessage = "Vui lòng nhập họ và tên của bạn.";
        _colorMessage = AppColors.red;
      } else if (!_filledFamilyName) {
        _textMessage = "Vui lòng nhập họ của bạn.";
        _colorMessage = AppColors.red;
      } else if (!_filedName) {
        _textMessage = "Vui lòng nhập tên của bạn.";
        _colorMessage = AppColors.red;
      } else {
        _textMessage = "Nhập tên bạn sử dụng trong đời thực.";
        _colorMessage = AppColors.gray;
      }
    });
  }
}

class DateOfBirth extends StatefulWidget {
  const DateOfBirth({super.key});

  @override
  State<DateOfBirth> createState() => _DateOfBirthState();
}

class _DateOfBirthState extends State<DateOfBirth> {
  DateTime? _selectedDate;
  String _age = "";
  String _ageMessage =
      "Chọn ngày sinh của bạn. Bạn luôn có thể đặt thông tin này ở chế độ riêng tư vào lúc khác";
  bool _boolAgeError = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Ngày sinh",
            style: TextStyle(
              color: AppColors.black,
            )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: AppColors.black,
          onPressed: () {
            showAlertDialog(context);
          },
        ),
        backgroundColor: AppColors.white,
      ),
      body: Column(children: [
        Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.075),
            child: const Text("Ngày sinh của bạn là khi nào?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.025,
                left: screenWidth * 0.04,
                right: screenWidth * 0.04),
            child: Text(_ageMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _boolAgeError ? AppColors.red : AppColors.gray,
                  fontSize: 18,
                ))),
        Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.05,
              left: screenWidth * 0.2,
              right: screenWidth * 0.2),
          child: DatePickerWidget(
            looping: true, // default is not looping
            firstDate: DateTime(1890, 01, 01),
            lastDate: DateTime(2100, 1, 1),
            initialDate: DateTime.now(),
            dateFormat: "dd-MMM-yyyy",
            locale: DatePicker.localeFromString('vi'),
            onChange: (DateTime newDate, _) {
              setState(() {
                _selectedDate = newDate;
              });
              getAge();
            },
            pickerTheme: DateTimePickerTheme(
              backgroundColor: Colors.transparent,
              itemTextStyle: TextStyle(color: Colors.black, fontSize: 17),
              dividerColor: AppColors.gray,
            ),
          ),
        ),
        // Text(_age + ' tuổi'),
        Container(
          height: 15,
          child: Visibility(
            visible: (_age != ""),
            child: Text(_age + ' tuổi'),
          ),
        ),
        Container(
            margin: EdgeInsets.only(
                top: screenHeight * 0.06,
                left: screenWidth * 0.04,
                right: screenWidth * 0.04),
            height: screenHeight * 0.055,
            width: screenWidth,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_selectedDate == null) {
                      _boolAgeError = true;
                      _ageMessage = "Vui lòng chọn ngày sinh nhật của bạn.\n";
                      return;
                    }
                  });
                  if (double.parse(_age) < 5) return;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Gender()));
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
                child: const Text("Tiếp",
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold))))
      ]),
    );
  }

  void getAge() {
    setState(() {
      int? tmp;
      int leapDays = 0;
      tmp = (DateTime.now().difference(_selectedDate!)).inDays;
      for (int year = _selectedDate!.year;
          year <= DateTime.now().year;
          year++) {
        if (year % 4 == 0) {
          if (year % 100 == 0) {
            if (year % 400 == 0) {
              leapDays++;
            }
          }
        }
      }
      // _age = ((tmp - leapDays - 1) ~/ 365).toString() + " tuổi";
      tmp = (tmp - leapDays - 1) ~/ 365;

      if (tmp < 5) {
        _boolAgeError = true;
        _ageMessage =
            "Hình như bạn đã nhập sai thông tin. Hãy nhớ dùng ngày sinh nhật thật của mình nhé.";
      } else {
        _boolAgeError = false;
        _ageMessage =
            "Chọn ngày sinh của bạn. Bạn luôn có thể đặt thông tin này ở chế độ riêng tư vào lúc khác";
      }
      if (tmp < 0) tmp = 0;
      _age = tmp.toString();
    });
  }
}

class Gender extends StatefulWidget {
  const Gender({super.key});

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  int _gender = -1;
  String _genderMessage =
      "Bạn có thể thay đổi ai nhìn thấy giới tính của mình trên trang cá nhân vào lúc khác.";
  bool _boolGenderError = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Giới tính",
            style: TextStyle(
              color: AppColors.black,
            )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: AppColors.black,
          onPressed: () {
            showAlertDialog(context);
          },
        ),
        backgroundColor: AppColors.white,
      ),
      body: Column(children: [
        Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.075),
            child: const Text("Giới tính của bạn là gì?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.025,
                left: screenWidth * 0.04,
                right: screenWidth * 0.04),
            child: Text(_genderMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _boolGenderError ? AppColors.red : AppColors.gray,
                  fontSize: 17,
                ))),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.05,
                // left: screenWidth * 0.04,
                // right: screenWidth * 0.04
              ),
              child: RadioListTile(
                  title: Text(
                    "Nữ",
                    style: TextStyle(
                        color:
                            _boolGenderError ? AppColors.red : AppColors.black),
                    textAlign: TextAlign.start,
                  ),
                  value: 0,
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = 0;
                      _boolGenderError = false;
                      _genderMessage =
                          "Bạn có thể thay đổi ai nhìn thấy giới tính của mình trên trang cá nhân vào lúc khác.";
                    });
                  },
                  // shape: Border(
                  //     bottom: BorderSide(width: 1.5, color: AppColors.gray)),
                  controlAffinity: ListTileControlAffinity.trailing),
            ),
            Container(
                color: AppColors.gray,
                height: screenWidth * 0.003,
                width: screenWidth * 0.95,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.04, right: screenWidth * 0.04),
                )),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.015),
              child: RadioListTile(
                title: Text("Nam",
                    style: TextStyle(
                        color: _boolGenderError
                            ? AppColors.red
                            : AppColors.black)),
                value: 1,
                groupValue: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = 1;
                    _boolGenderError = false;
                    _genderMessage =
                        "Bạn có thể thay đổi ai nhìn thấy giới tính của mình trên trang cá nhân vào lúc khác.";
                  });
                },
                // shape: Border(
                //     bottom: BorderSide(width: 1.5, color: AppColors.gray)),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ),
            Container(
                color: AppColors.gray,
                height: screenWidth * 0.003,
                width: screenWidth * 0.95,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.04, right: screenWidth * 0.04),
                )),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.015),
              child: RadioListTile(
                title: Text("Tùy chỉnh",
                    style: TextStyle(
                        color: _boolGenderError
                            ? AppColors.red
                            : AppColors.black)),
                subtitle: Text(
                    "Chọn Tùy chỉnh nếu bạn thuộc giới tính khác hoặc\nkhông muốn tiết lộ."),
                value: 2,
                groupValue: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = 2;
                    _boolGenderError = false;
                    _genderMessage =
                        "Bạn có thể thay đổi ai nhìn thấy giới tính của mình trên trang cá nhân vào lúc khác.";
                  });
                },
                // shape: Border(
                //     bottom: BorderSide(
                //         width: 1.5,
                //         color: AppColors.gray,
                //         strokeAlign: StrokeAlign.inside)),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ),
            Container(
                color: AppColors.gray,
                height: screenWidth * 0.003,
                width: screenWidth * 0.95,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.04, right: screenWidth * 0.04),
                ))
          ],
        ),
        Container(
            margin: EdgeInsets.only(
                top: screenHeight * 0.06,
                left: screenWidth * 0.04,
                right: screenWidth * 0.04),
            height: screenHeight * 0.055,
            width: screenWidth,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_gender == -1) {
                      _boolGenderError = true;
                      _genderMessage = "Vui lòng chọn giới tính của bạn.\n";
                    } else {
                      _boolGenderError = false;
                    }
                  });
                  if (_boolGenderError) return;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PhoneNumber()));
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
                child: const Text("Tiếp",
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold))))
      ]),
    );
  }
}

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  String _phoneNumberMessage = _messagePhone;
  // String _phoneNumberMessage =
  //     "Nhập số di động để liên hệ của bạn. Bạn có thể ẩn thông tin này trên trang cá nhân sau.";
  bool _boolPhoneNumberError = true;

  TextEditingController _phone = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Số di động",
            style: TextStyle(
              color: AppColors.black,
            )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: AppColors.black,
          onPressed: () {
            showAlertDialog(context);
          },
        ),
        backgroundColor: AppColors.white,
      ),
      body: Column(children: [
        Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.075),
            child: const Text("Nhập số di động của bạn",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.025,
                left: screenWidth * 0.04,
                right: screenWidth * 0.04),
            child: Text(_phoneNumberMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ((_phoneNumberMessage ==
                              "Vui lòng nhập số di động của bạn.\n") ||
                          _phoneNumberMessage == "Số di động không hợp lệ.\n" ||
                          _phoneNumberMessage ==
                              "Hiện đã có tài khoản đăng ký với số điện thoại này.\n")
                      ? AppColors.red
                      : AppColors.gray,
                  fontSize: 18,
                ))),
        Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.05,
                left: screenWidth * 0.04,
                right: screenWidth * 0.04),
            child: TextFormField(
                controller: _phone,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Số di động",
                  labelText: "Số di động",
                ),
                onChanged: ((value) {
                  setState(() {
                    if (value.isEmpty) {
                      _boolPhoneNumberError = true;
                      // _phoneNumberMessage = "Vui lòng nhập số di động của bạn.\n";
                    }
                    if (value.isNotEmpty) {
                      _boolPhoneNumberError = false;
                      // _phoneNumberMessage =
                      //     "Nhập số di động để liên hệ của bạn. Bạn có thể ẩn thông tin này trên trang cá nhân sau.";
                    }
                  });
                }))),
        Container(
            margin: EdgeInsets.only(
                top: screenHeight * 0.06,
                left: screenWidth * 0.04,
                right: screenWidth * 0.04),
            height: screenHeight * 0.055,
            width: screenWidth,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_boolPhoneNumberError) {
                      _phoneNumberMessage =
                          "Vui lòng nhập số di động của bạn.\n";
                    } else {
                      if (_phone.text.length != 10 ||
                          _phone.text[0].toString() != "0") {
                        _phoneNumberMessage = "Số di động không hợp lệ.\n";
                      } else {
                        _phoneNumberMessage =
                            "Hiện đã có tài khoản đăng ký với số điện thoại này.\n";
                      }
                    }
                  });
                  if (_boolPhoneNumberError ||
                      _phoneNumberMessage == "Số di động không hợp lệ.\n") {
                    return;
                  }
                  _phoneNumber = _phone.text.toString();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Password()));
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
                child: const Text("Tiếp",
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)))),
        Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.25),
          child: GestureDetector(
              onTap: () => {},
              child: Text("Đăng ký bằng địa chỉ email",
                  style: TextStyle(
                      color: AppColors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold))),
        ),
      ]),
    );
  }
}

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  String _passwordMessage =
      "Tạo mật khẩu gồm tối thiểu 6 ký tự. Đó phải là mật khẩu mà người khác không đoán được.";
  Color _colorMessage = AppColors.gray;
  bool _filedPassword = false;
  bool _showPass = false;

  TextEditingController _pass = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Mật khẩu",
            style: TextStyle(
              color: AppColors.black,
            )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: AppColors.black,
          onPressed: () {
            showAlertDialog(context);
          },
        ),
        backgroundColor: AppColors.white,
      ),
      body: Column(children: [
        Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.075),
            child: const Text("Chọn mật khẩu",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.025,
                left: screenWidth * 0.04,
                right: screenWidth * 0.04),
            child: Text(_passwordMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ((_passwordMessage == "Vui lòng nhập mật khẩu.\n") ||
                          (_passwordMessage == "Mật khẩu quá ngắn.\n"))
                      ? AppColors.red
                      : AppColors.gray,
                  fontSize: 18,
                ))),
        Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.05,
              left: screenWidth * 0.04,
              right: screenWidth * 0.04),
          child: Stack(alignment: AlignmentDirectional.centerEnd, children: [
            TextFormField(
              controller: _pass,
              obscureText: !_showPass,
              obscuringCharacter: "•",
              onChanged: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    _filedPassword = true;
                    // _colorMessage = AppColors.gray;
                    // _passwordMessage =
                    //     "Tạo mật khẩu gồm tối thiểu 6 ký tự. Đó phải là mật khẩu mà người khác không đoán được.";
                  }
                  if (value.isEmpty) {
                    _filedPassword = false;
                    // _colorMessage = AppColors.red;
                    // _passwordMessage = "Vui lòng nhập mật khẩu.\n";
                  }
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
        ),
        Container(
            margin: EdgeInsets.only(
                top: screenHeight * 0.06,
                left: screenWidth * 0.04,
                right: screenWidth * 0.04),
            height: screenHeight * 0.055,
            width: screenWidth,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (!_filedPassword) {
                      _passwordMessage = "Vui lòng nhập mật khẩu.\n";
                    } else {
                      if (_pass.text.length < 6) {
                        _passwordMessage = "Mật khẩu quá ngắn.\n";
                      } else {
                        _passwordMessage =
                            "Tạo mật khẩu gồm tối thiểu 6 ký tự. Đó phải là mật khẩu mà người khác không đoán được.";
                      }
                    }
                  });
                  if (!_filedPassword || (_pass.text.length < 6)) {
                    return;
                  }
                  _password = _pass.text.toString();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CompleteRegister()));
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
                child: const Text("Tiếp",
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)))),
      ]),
    );
  }

  void onToggleChangePass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}

class CompleteRegister extends StatefulWidget {
  const CompleteRegister({super.key});

  @override
  State<CompleteRegister> createState() => _CompleteRegisterState();
}

class _CompleteRegisterState extends State<CompleteRegister> {
  Future<List<Register>>? _register;
  bool _isRegister = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Điều khoản & quyền riêng tư",
            style: TextStyle(
              color: AppColors.black,
            )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: AppColors.black,
          onPressed: () {
            showAlertDialog(context);
          },
        ),
        backgroundColor: AppColors.white,
      ),
      body: Column(children: [
        Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.075),
            child: const Text("Hoàn tất đăng ký",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.025,
              left: screenWidth * 0.02,
              right: screenWidth * 0.02,
            ),
            child: const Center(
              child: Text.rich(
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.gray),
                  TextSpan(
                      // text: 'Bằng cách nhần vào Đăng ký, bạn đồng ý với ',
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Bằng cách nhần vào Đăng ký, bạn đồng ý với',
                        ),
                        TextSpan(
                            text: ' Điều khoản, Chính sách dữ liệu',
                            style: TextStyle(color: AppColors.blue)),
                        TextSpan(text: ' và'),
                        TextSpan(
                            text: ' Chính sách cookie',
                            style: TextStyle(color: AppColors.blue)),
                        TextSpan(
                          text: ' của chúng thôi. Bạn có thể nhận được thông báo của chúng tôi qua SMS và chọn không nhận bất cứ lúc nào.\n' +
                              'Thông tin từ danh bạn của bạn sẽ được tải lên Facebook liên tục để chúng tôi có thể gợi ý kết bạn, cung cấp, cải thiện ' +
                              'quảng cáo cho bạn và người khác, cũng như mang đến dịch vụ tốt hơn.',
                        ),
                      ])),
            )),
        Container(
            margin: EdgeInsets.only(
                top: screenHeight * 0.06,
                left: screenWidth * 0.04,
                right: screenWidth * 0.04),
            height: screenHeight * 0.055,
            width: screenWidth,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isRegister = true;
                    _register = signUp(_phoneNumber.toString(),
                        _password.toString(), _fullName.toString());
                  });
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
                child: const Text("Đăng ký",
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)))),
        Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.03),
          child: GestureDetector(
              onTap: () => {},
              child: Text("Đăng ký mà không tải danh bạ của tôi lên",
                  style: TextStyle(
                      color: AppColors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold))),
        ),
        SizedBox(
          height: 30,
        ),
        Visibility(
          visible: _isRegister,
          child: FutureBuilder(
              future: _register,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return const SizedBox.shrink();
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Container(
                  height: 30,
                  width: 30,
                  child: Center(child: CircularProgressIndicator()),
                );
              }),
        ),
      ]),
    );
  }

  List<Register> parseRegister(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Register> users =
        list.map((model) => Register.fromJson(model)).toList();
    return users;
  }

  Future<List<Register>> signUp(
      String phoneNumber, String password, String username) async {
    final response = await http.post(Uri.parse(
        "https://flutter-hust.onrender.com/it4788/auth/signup?phonenumber=${phoneNumber}&password=${password}&username=${username}"));
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      _messagePhone = "Hiện đã có tài khoản đăng ký với số điện thoại này.\n";
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PhoneNumber()));
    }
    return compute(parseRegister, "[" + response.body + "]");
  }
}

showAlertDialog(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Dừng tạo tài khoản"),
    onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    },
  );
  Widget continueButton = TextButton(
    child:
        Text("Tiếp tục tạo tài khoản", style: TextStyle(color: AppColors.gray)),
    onPressed: () {
      Navigator.of(context).pop();
      ;
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Bạn có muốn dừng tạo tài khoản không?"),
    content: Container(
      height: screenHeight * 0.25,
      width: screenWidth * 0.8,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.05),
            child: Text(
                "Nếu dùng bây giờ, bạn sẽ mất toàn bộ tiến trình cho đến nay.",
                style: TextStyle(color: AppColors.gray)),
          ),

          Container(alignment: Alignment.bottomRight, child: continueButton),

          Container(alignment: Alignment.bottomRight, child: cancelButton),
          // cancelButton,
        ],
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
