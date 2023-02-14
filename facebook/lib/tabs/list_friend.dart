// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';

import 'package:facebook/tabs/profile_tab.dart';
import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../services/remote_service.dart';
import '../values/api_values.dart';
import '../values/app_colors.dart';
import '../widgets/element_friend.dart';
import 'list_block.dart';
import 'package:http/http.dart' as http;

class ListFriends extends StatefulWidget {
  // const ListFriends({super.key});
  String? id;
  ListFriends({this.id});

  @override
  State<ListFriends> createState() => ListFriendsState(id: id);
}

class ListFriendsState extends State<ListFriends> {
  String? id;
  ListFriendsState({this.id});
  @override
  void initState() {
    //refresh the page here
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Trang cá nhân",
              style: TextStyle(
                color: AppColors.black,
              )),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: AppColors.black,
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => HomePage()));
              Navigator.pop(context);
            },
          ),
          backgroundColor: AppColors.white,
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.025,
                  vertical: screenHeight * 0.025),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text('Tất cả',
                            style: TextStyle(
                                color: AppColors.blue,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(30.0)),
                        child: const Text('Gần đây',
                            style: TextStyle(
                                fontSize: 17.0, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Visibility(
                          visible: (id == ApiValues.ID),
                          child: Container(
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => ListBlocks()));

                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            ListBlocks(id: this.id),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: const Text('Chặn',
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  Container(
                    height: screenHeight * 0.05,
                    width: screenWidth * 0.9,
                    child: Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          // ignore: prefer_const_constructors
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ), // icon is 48px widget.
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: "Tìm kiếm bạn bè",
                          contentPadding: EdgeInsets.all(0),
                          hintStyle: const TextStyle(
                              fontSize: 17, color: AppColors.gray),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  Row(
                    children: <Widget>[
                      const Text('Bạn bè',
                          style: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black)),
                      SizedBox(width: screenWidth * 0.02),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  FutureBuilder(
                      future: getListFriend(
                          ApiValues.TOKEN.toString(), id.toString()),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          // DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse();
                          return Column(
                            children: [
                              ListView.builder(
                                  // scrollDirection: Axis.horizontal,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount:
                                      int.parse(snapshot.data[0].data.total),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        elementFriend(
                                            name: snapshot.data[0].data
                                                .friends[index].username,
                                            avatar: snapshot.data[0].data
                                                .friends[index].avatar,
                                            id: snapshot.data[0].data
                                                .friends[index].id),
                                        SizedBox(height: screenHeight * 0.025),
                                      ],
                                    );
                                  }),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text("Hiện tại chưa có bạn bè.",
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
                ],
              )),
        ));
  }
}
