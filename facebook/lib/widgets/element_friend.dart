import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../services/remote_service.dart';
import '../tabs/profile_tab.dart';
import '../values/api_values.dart';
import '../values/app_colors.dart';

// String isFriend = "123", code = "";
// Future<void> getInfo(String token, String id) async {
//   final response = await http.post(
//     Uri.parse(
//         "https://flutter-hust.onrender.com/it4788/user/get_user_info?token=${token}&user_id=${id}"),
//     body: jsonEncode(<String, String>{
//       'token': token,
//       'user_id': id,
//     }),
//   );
//   final data = json.decode(response.body);
//   if (response.statusCode == 200) {
//     isFriend = data['data']['is_friend'];
//     code = data['code'];
//   }
// }

class elementFriend extends StatefulWidget {
  // const elementFriend({super.key});
  String? name;
  String? avatar;
  String? id;
  elementFriend({this.name, this.avatar, this.id});
  @override
  State<elementFriend> createState() =>
      _elementFriendState(name: name, avatar: avatar, id: id);
}

class _elementFriendState extends State<elementFriend> {
  String? name;
  String? avatar;
  String? id;
  _elementFriendState({this.name, this.avatar, this.id});
  String message = "Thêm bạn bè";
  Color colorMessage = AppColors.white;
  bool isRequest = false;

  String isFriend = "", code = "";
  Future<String?> getInfo(String token, String id) async {
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
    return isFriend;
  }

  @override
  void initState() {
    //refresh the page here
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void test() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Widget Friend = Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(avatar.toString()),
          radius: 40.0,
        ),
        SizedBox(width: screenWidth * 0.025),
        Container(
            width:
                (isFriend == "false") ? screenWidth * 0.275 : screenWidth * 0.5,
            child: Text(name!,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold))),
        SizedBox(height: screenHeight * 0.025),
        Visibility(
            visible:
                (isFriend == "true" && code == "1000" && id != ApiValues.ID),
            child: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.1),
              child: GestureDetector(
                  onTap: () {
                    showAlertDialog(context, name.toString(), id.toString());
                    // .then((value) => setState(() {}));
                    // Timer.periodic(Duration(milliseconds: 50), (timer) {
                    //   setState(() {});
                    // });
                  },
                  child: const Text("•••", style: TextStyle(fontSize: 15))),
            )),
        Visibility(
          visible:
              (isFriend == "false" && code == "1000" && id != ApiValues.ID),
          child: (!isRequest)
              ? Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.1),
                  child: Container(
                      height: screenHeight * 0.044,
                      width: screenWidth * 0.3,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // isConfirm = true;
                            // AcceptFriend(ApiValues.TOKEN.toString(), id, "1");
                            message = "Đã gửi lời mời kết bạn";
                            colorMessage = AppColors.gray;
                            isRequest = true;
                            setRequestFriend(
                                ApiValues.TOKEN.toString(), id.toString());
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue),
                        child: Text(message,
                            style: TextStyle(
                                color: colorMessage,
                                fontSize: 13,
                                fontWeight: FontWeight.bold)),
                      )),
                )
              : Text(message),
        ),
        // Padding(
        //   padding: EdgeInsets.only(left: screenWidth * 0.1),
        //   child: GestureDetector(
        //       onTap: () {
        //         showAlertDialog(context, name.toString(), id.toString());
        //       },
        //       child: const Text("•••", style: TextStyle(fontSize: 15))),
        // )
      ],
    );
    // return GestureDetector(
    //     onTap: (() {
    //       Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) =>
    //                   ProfileTab(name: name, id: id, avatar: avatar)));
    //     }),
    //     child: Visibility(visible: (code != "9995"), child: Friend));
    return FutureBuilder(
        future: getInfo(ApiValues.TOKEN.toString(), id.toString()),
        // .then((data) {
        //   // setState(() {});
        // }),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProfileTab(name: name, id: id, avatar: avatar)));
                }),
                child: Visibility(visible: (code != "9995"), child: Friend));
          } else if (snapshot.hasError) {
            return Text("No data");
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  showAlertDialog(BuildContext context, String name, String id) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var heightAppBar = AppBar().preferredSize.height;
    double heightDialog = screenHeight * 0.55;
    // set up the buttons
    Widget seeFriends = Container(
        height: heightDialog * 0.14,
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.15,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 0, left: 0, right: screenWidth * 0.02),
                child: Image.asset("assets/images/seeFriends.png"),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Xem bạn bè của " + name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColors.black, fontSize: 18)),
                ),
              ),
            ),
          ],
        ));

    Widget message = Container(
        height: heightDialog * 0.14,
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.15,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 0, left: 0, right: screenWidth * 0.02),
                child: Image.asset("assets/images/messenger.png"),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Nhắn tin cho " + name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColors.black, fontSize: 18)),
                ),
              ),
            ),
          ],
        ));

    Widget unfollow = Container(
        height: heightDialog * 0.24,
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.15,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 0, left: 0, right: screenWidth * 0.02),
                child: Image.asset("assets/images/unfollow.png"),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.0),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.015),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                              text: 'Bỏ theo dõi ' + name.toString(),
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 18))),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                              text: 'Dừng xem bài viết nhưng vẫn là bạn bè.',
                              style: TextStyle(
                                  color: AppColors.gray, fontSize: 18))),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));

    Widget block = Container(
        height: heightDialog * 0.24,
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.15,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 0, left: 0, right: screenWidth * 0.02),
                child: Image.asset("assets/images/block.png"),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.0),
                child: Column(
                  children: [
                    // SizedBox(height: screenHeight * 0.015),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text.rich(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                              text: 'Chặn trang cá nhân của ' + name.toString(),
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 18))),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text.rich(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                              text: name.toString() +
                                  ' sẽ không thể nhìn thấy bạn hoặc liên hệ với bạn trên Facebook',
                              style: TextStyle(
                                  color: AppColors.gray, fontSize: 18))),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));

    Widget unfriend = Container(
        height: heightDialog * 0.24,
        child: Row(children: [
          Container(
            width: screenWidth * 0.15,
            child: Padding(
              padding:
                  EdgeInsets.only(top: 0, left: 0, right: screenWidth * 0.02),
              child: Image.asset("assets/images/unfriend.png"),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.0),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.035),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text.rich(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        TextSpan(
                            text: 'Hủy kết bạn với ' + name.toString(),
                            style:
                                TextStyle(color: AppColors.red, fontSize: 18))),
                  ),
                  // Align(
                  //   alignment: AlignmentDirectional.centerStart,
                  //   child: Text.rich(
                  //       maxLines: 2,
                  //       overflow: TextOverflow.ellipsis,
                  //       TextSpan(
                  //           text: 'Hủy kết bạn với ' + name.toString(),
                  //           style: TextStyle(
                  //               color: AppColors.gray, fontSize: 18))),
                  // )
                ],
              ),
            ),
          ),
        ]));
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        content: Container(
          height: heightDialog,
          width: screenWidth,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.0),
                  child: seeFriends,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.0),
                  child: message,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.0),
                  child: unfollow,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setBlock(ApiValues.TOKEN.toString(), id.toString(), "0");
                  Navigator.of(context, rootNavigator: true).pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.0),
                  child: block,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setUnfriend(ApiValues.TOKEN.toString(), id.toString(), "0");
                  Navigator.of(context, rootNavigator: true).pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.0),
                  child: unfriend,
                ),
              ),
            ],
          ),
        ),
        insetPadding: EdgeInsets.only(
            top: (screenHeight - heightDialog - 1.11 * heightAppBar)));

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
