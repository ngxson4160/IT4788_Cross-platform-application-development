// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:facebook/tabs/profile_tab.dart';
import 'package:flutter/material.dart';
import '../services/remote_service.dart';
import '../values/api_values.dart';
import '../values/app_colors.dart';
import '../widgets/element_block.dart';
import '../widgets/element_friend.dart';
import 'list_friend.dart';

class ListBlocks extends StatefulWidget {
  // const ListBlocks({super.key});
  String? id;
  ListBlocks({this.id});
  @override
  State<ListBlocks> createState() => _ListFriendsState(id: this.id);
}

class _ListFriendsState extends State<ListBlocks> {
  String? id;
  _ListFriendsState({this.id});
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
              //     MaterialPageRoute(builder: (context) => ProfileTab()));
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  ListFriends(id: this.id),
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
                          child: Text('Tất cả',
                              style: TextStyle(
                                  fontSize: 17.0, fontWeight: FontWeight.bold)),
                        ),
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
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(30.0)),
                        child: const Text('Chặn',
                            style: TextStyle(
                                color: AppColors.blue,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  Row(
                    children: <Widget>[
                      const Text('Danh sách những người đã chặn',
                          style: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black)),
                      SizedBox(width: screenWidth * 0.02),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  FutureBuilder(
                      future: getListBlock(ApiValues.TOKEN.toString()),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          // DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse();
                          return Column(
                            children: [
                              ListView.builder(
                                  // scrollDirection: Axis.horizontal,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data[0].data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        elementBlock(
                                            name: snapshot.data[0].data[index]
                                                    .username ??
                                                "null",
                                            avatar: snapshot.data[0].data[index]
                                                    .avatar ??
                                                "",
                                            id: snapshot
                                                .data[0].data[index].id),
                                      ],
                                    );
                                  }),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text("Hiện tại bạn chưa chặn ai.",
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
