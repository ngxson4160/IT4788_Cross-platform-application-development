// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';
import 'package:facebook/values/api_values.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/ListRequestFriend.dart';
import '../services/remote_service.dart';
import '../values/app_colors.dart';
import '../widgets/element_suggestFriends.dart';
import '../widgets/request_friend_widget.dart';
import 'list_friend.dart';

class FriendRequestPage extends StatefulWidget {
  const FriendRequestPage({super.key});

  @override
  State<FriendRequestPage> createState() => _FriendRequestPageState();
}

class _FriendRequestPageState extends State<FriendRequestPage> {
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
              backgroundImage: AssetImage('assets/images/logoFacebook.png'),
              radius: 40.0,
            ),
            SizedBox(width: screenWidth * 0.025),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Chris',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                SizedBox(height: screenHeight * 0.025),
                Visibility(
                  visible: !isConfirm,
                  child: confirmOrCancel,
                ),
                Visibility(
                    visible: isConfirm,
                    child: Container(
                      height: screenHeight * 0.044,
                      width: screenWidth * 0.325,
                      child: Text("Các bạn đã là bạn bè",
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

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.025, vertical: screenHeight * 0.025),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Bạn bè',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              SizedBox(height: screenHeight * 0.025),
              Row(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30.0)),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {});
                      },
                      child: Text('Gợi ý',
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30.0)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListFriends()));
                      },
                      child: const Text('Bạn bè',
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
              SizedBox(height: screenHeight * 0.015),
              Container(
                  color: AppColors.gray,
                  height: screenWidth * 0.002,
                  width: screenWidth * 0.95,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.04, right: screenWidth * 0.04),
                  )),
              SizedBox(height: screenHeight * 0.015),
              // numberOfRequests(screenWidth),
              SizedBox(height: screenHeight * 0.025),
              FutureBuilder(
                  future: getRequestFriend(ApiValues.TOKEN.toString()),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      // DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse();
                      return Column(
                        children: [
                          numberOfRequests(
                              screenWidth, snapshot.data[0].data.total),
                          SizedBox(height: screenHeight * 0.025),
                          ListView.builder(
                              // physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: int.parse(snapshot.data[0].data.total),
                              itemBuilder: (BuildContext context, int index) {
                                return RequestFriend(
                                    name: snapshot.data[0].data.request[index]
                                            .username ??
                                        "null",
                                    created: DateFormat(
                                            "'G'ửi lú'c' HH:mm ngà'y' dd/MM/yyyy")
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(snapshot
                                                        .data[0]
                                                        .data
                                                        .request[index]
                                                        .created) *
                                                    1000))
                                        .toString(),
                                    id: snapshot.data[0].data.request[index].id,
                                    avatar: snapshot
                                        .data[0].data.request[index].avatar);
                              }),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Text("Hiện tại chưa có lời kết bạn.",
                          style: TextStyle(
                              fontSize: 18.5, fontWeight: FontWeight.bold));
                    } else {
                      return Container(
                        height: 20,
                        width: 20,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  }),
              SizedBox(height: screenHeight * 0.015),
              Container(
                  color: AppColors.gray,
                  height: screenWidth * 0.002,
                  width: screenWidth * 0.95,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.04, right: screenWidth * 0.04),
                  )),
              SizedBox(height: screenHeight * 0.015),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text('Những người bạn có thể biết',
                      style: TextStyle(
                          fontSize: 19.0, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: screenHeight * 0.025),
              FutureBuilder(
                  future: getSuggestFriends(ApiValues.TOKEN.toString()),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      // DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse();
                      return Column(
                        children: [
                          SizedBox(height: screenHeight * 0.025),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data[0].data.listUsers.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  child: SuggestFriend(
                                      name: snapshot.data[0].data
                                              .listUsers[index].username ??
                                          "null",
                                      sameFriend: snapshot.data[0].data
                                          .listUsers[index].sameFriends,
                                      id: snapshot
                                          .data[0].data.listUsers[index].userId,
                                      avatar: snapshot.data[0].data
                                          .listUsers[index].avatar),
                                );
                              }),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("",
                          style: TextStyle(
                              fontSize: 18.5, fontWeight: FontWeight.bold));
                    } else {
                      return Container(
                        height: 20,
                        width: 20,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  }),
              // Row(
              //   children: <Widget>[
              //     CircleAvatar(
              //       backgroundImage: AssetImage('assets/mathew.jpg'),
              //       radius: 40.0,
              //     ),
              //     SizedBox(width: screenWidth * 0.025),
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Text('Mathew',
              //             style: TextStyle(
              //                 fontSize: 16.0, fontWeight: FontWeight.bold)),
              //         SizedBox(height: screenHeight * 0.025),
              //         Row(
              //           children: <Widget>[
              //             Container(
              //               height: screenHeight * 0.044,
              //               width: screenWidth * 0.325,
              //               child: ElevatedButton(
              //                   onPressed: () {
              //                     // Navigator.push(
              //                     //     context,
              //                     //     MaterialPageRoute(
              //                     //         builder: (context) => FriendsTab()));
              //                   },
              //                   style: ElevatedButton.styleFrom(
              //                       backgroundColor: AppColors.blue),
              //                   child: const Text("Xác nhận",
              //                       style: TextStyle(
              //                           color: AppColors.white,
              //                           fontSize: 16,
              //                           fontWeight: FontWeight.bold))),
              //             ),
              //             SizedBox(width: screenWidth * 0.02),
              //             Container(
              //               height: screenHeight * 0.044,
              //               width: screenWidth * 0.325,
              //               child: ElevatedButton(
              //                   onPressed: () {
              //                     // Navigator.push(
              //                     //     context,
              //                     //     MaterialPageRoute(
              //                     //         builder: (context) => FriendsTab()));
              //                   },
              //                   style: ElevatedButton.styleFrom(
              //                       backgroundColor: Colors.grey[300]),
              //                   child: const Text("Xóa",
              //                       style: TextStyle(
              //                           color: AppColors.black,
              //                           fontSize: 14.5,
              //                           fontWeight: FontWeight.bold))),
              //             ),
              //           ],
              //         )
              //       ],
              //     )
              //   ],
              // ),
              SizedBox(height: screenHeight * 0.025),
            ],
          )),
    ));
  }

  Row numberOfRequests(double screenWidth, String numberRequest) {
    return Row(
      children: <Widget>[
        const Text('Lời mời kết bạn',
            style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: AppColors.black)),
        SizedBox(width: screenWidth * 0.02),
        Text(numberRequest,
            style: TextStyle(
                color: AppColors.red,
                fontSize: 21.0,
                fontWeight: FontWeight.bold)),
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.3),
          child: Text("Xem tất cả",
              textAlign: TextAlign.right,
              style: TextStyle(color: AppColors.blue, fontSize: 16.0)),
        ),
      ],
    );
  }

  // List<ListRequestFriend> parseListRequest(String responseBody) {
  //   var list = json.decode(responseBody) as List<dynamic>;
  //   List<ListRequestFriend> listRequest =
  //       list.map((model) => ListRequestFriend.fromJson(model)).toList();
  //   return listRequest;
  // }

  // Future<List<ListRequestFriend>> getRequestFriend(String token) async {
  //   final response = await http.post(Uri.parse(
  //       "https://flutter-hust.onrender.com/it4788/friend/get_requested_friends?token=${token}&index=0&count=500"));
  //   if (response.statusCode == 200) {
  //     return compute(parseListRequest, "[" + response.body + "]");
  //   } else {
  //     throw Exception("Request Api Error");
  //   }
  // }
}

// List<ListRequestFriend> parseListRequest(String responseBody) {
//   var list = json.decode(responseBody) as List<dynamic>;
//   List<ListRequestFriend> listRequest =
//       list.map((model) => ListRequestFriend.fromJson(model)).toList();
//   return listRequest;
// }

// Future<List<ListRequestFriend>> getRequestFriend(String token) async {
//   final response = await http.post(Uri.parse(
//       "https://flutter-hust.onrender.com/it4788/friend/get_requested_friends?token=${token}&index=0&count=500"));
//   if (response.statusCode == 200) {
//     return compute(parseListRequest, "[" + response.body + "]");
//   } else {
//     // Navigator.push(context,
//                     //     MaterialPageRoute(builder: (context) => LoginPage()));
//     throw Exception("Request Api Error");
//   }
// }
