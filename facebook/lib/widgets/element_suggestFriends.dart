import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/remote_service.dart';
import '../values/api_values.dart';
import '../values/app_colors.dart';

class SuggestFriend extends StatefulWidget {
  // SuggestFriend({super.key});

  String? name;
  String? sameFriend;
  String? avatar;
  String id;
  SuggestFriend(
      {super.key, this.name, this.sameFriend, this.avatar, required this.id});
  @override
  State<SuggestFriend> createState() => _SuggestFriendState(
      name: this.name,
      sameFriend: this.sameFriend,
      avatar: this.avatar,
      id: this.id);
}

class _SuggestFriendState extends State<SuggestFriend> {
  String? name;
  String? sameFriend;
  String? avatar;
  String id;
  _SuggestFriendState(
      {this.name, this.sameFriend, this.avatar, required this.id});

  bool isConfirm = false;
  bool isCancel = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Widget confirmOrCancel = Row(
      children: <Widget>[
        Container(
          height: screenHeight * 0.044,
          width: screenWidth * 0.325,
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isConfirm = true;
                  setRequestFriend(ApiValues.TOKEN.toString(), id);
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
              child: const Text("Kết bạn",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold))),
        ),
        SizedBox(width: screenWidth * 0.02),
        Container(
          height: screenHeight * 0.044,
          width: screenWidth * 0.325,
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isCancel = true;
                });
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
              child: const Text("Xóa",
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold))),
        ),
      ],
    );

    Widget request = Column(
      children: [
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(avatar.toString()),
              radius: 40.0,
            ),
            SizedBox(width: screenWidth * 0.025),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name!,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                // SizedBox(height: screenHeight * 0.025),
                SizedBox(height: 3),
                Text(sameFriend! + " bạn chung",
                    style: TextStyle(fontSize: 13.0, color: AppColors.gray)),
                SizedBox(height: 6),
                Visibility(
                  visible: !isConfirm,
                  child: confirmOrCancel,
                ),
                Visibility(
                    visible: isConfirm,
                    child: Container(
                      height: screenHeight * 0.044,
                      width: screenWidth * 0.5,
                      child: Text("Đã gửi lời mời kết bạn.",
                          style:
                              TextStyle(color: AppColors.gray, fontSize: 16.0)),
                    )),
              ],
            )
          ],
        ),
        SizedBox(height: screenHeight * 0.025),
      ],
    );

    return Visibility(
      visible: !isCancel,
      child: request,
    );
  }

  // Future<void> setRequestFriend(String token, String id) async {
  //   final response = await http.post(Uri.parse(
  //       "https://flutter-hust.onrender.com/it4788/friend/set_request_friend?token=${token}&user_id=${id}"));
  // }
}
