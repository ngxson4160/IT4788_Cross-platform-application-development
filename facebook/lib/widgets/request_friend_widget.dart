import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/remote_service.dart';
import '../tabs/profile_tab.dart';
import '../values/api_values.dart';
import '../values/app_colors.dart';

class RequestFriend extends StatefulWidget {
  // RequestFriend({super.key});

  String? name;
  String? created;
  String? avatar;
  String id;
  RequestFriend(
      {super.key, this.name, this.created, this.avatar, required this.id});
  @override
  State<RequestFriend> createState() => _RequestFriendState(
      name: this.name, created: this.created, avatar: this.avatar, id: this.id);
}

class _RequestFriendState extends State<RequestFriend> {
  String? name;
  String? created;
  String? avatar;
  String id;
  _RequestFriendState({this.name, this.created, this.avatar, required this.id});

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
                  AcceptFriend(ApiValues.TOKEN.toString(), id, "1");
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
              child: const Text("Xác nhận",
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
                  AcceptFriend(ApiValues.TOKEN.toString(), id, "0");
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
        GestureDetector(
          onTap: (() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProfileTab(name: name, avatar: avatar, id: id)));
          }),
          child: Row(
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
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                  // SizedBox(height: screenHeight * 0.025),
                  SizedBox(height: 3),
                  Text(created!,
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
                        child: Text("Các bạn đã là bạn bè",
                            style: TextStyle(
                                color: AppColors.gray, fontSize: 16.0)),
                      )),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.025),
      ],
    );

    return Visibility(
      visible: !isCancel,
      child: request,
    );
  }

  // Future<void> AcceptFriend(String token, String id, String isAccept) async {
  //   final response = await http.post(Uri.parse(
  //       "https://flutter-hust.onrender.com/it4788/friend/set_accept_friend?token=${token}&user_id=${id}&is_accept=${isAccept}"));
  // }
}

// Visibility element (double screenHeight, double screenWidth){
//     bool isConfirm = false;
//     bool isCancel = false;
//     return Visibility(
//       visible: !isCancel,
//       child: requestTest(screenHeight, screenWidth, isConfirm,
//           confirmOrCancelTest(screenHeight, screenWidth, isConfirm, isCancel)),
//     );
//   }

//   Row confirmOrCancelTest(
//       double screenHeight, double screenWidth, bool isConfirm, bool isCancel) {
//     return Row(
//       children: <Widget>[
//         Container(
//           height: screenHeight * 0.044,
//           width: screenWidth * 0.325,
//           child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   isConfirm = true;
//                 });
//               },
//               style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
//               child: const Text("Xác nhận",
//                   style: TextStyle(
//                       color: AppColors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold))),
//         ),
//         SizedBox(width: screenWidth * 0.02),
//         Container(
//           height: screenHeight * 0.044,
//           width: screenWidth * 0.325,
//           child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   isCancel = true;
//                 });
//               },
//               style:
//                   ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
//               child: const Text("Xóa",
//                   style: TextStyle(
//                       color: AppColors.black,
//                       fontSize: 14.5,
//                       fontWeight: FontWeight.bold))),
//         ),
//       ],
//     );
//   }

//   Column requestTest(double screenHeight, double screenWidth, bool isConfirm,
//       Widget confirmOrCancel) {
//     return Column(
//       children: [
//         Row(
//           children: <Widget>[
//             CircleAvatar(
//               backgroundImage: AssetImage('assets/images/logoFacebook.png'),
//               radius: 40.0,
//             ),
//             SizedBox(width: screenWidth * 0.025),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text('Chris',
//                     style:
//                         TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//                 SizedBox(height: screenHeight * 0.025),
//                 Visibility(
//                   visible: !isConfirm,
//                   child: confirmOrCancel,
//                 ),
//                 Visibility(
//                     visible: isConfirm,
//                     child: Container(
//                       height: screenHeight * 0.044,
//                       width: screenWidth * 0.325,
//                       child: Text("Các bạn đã là bạn bè",
//                           style:
//                               TextStyle(color: AppColors.gray, fontSize: 16.0)),
//                     )),
//               ],
//             )
//           ],
//         ),
//         SizedBox(height: screenHeight * 0.025),
//       ],
//     );
//   }