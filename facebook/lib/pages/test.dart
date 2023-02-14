import 'dart:async';

import 'package:comment_box/comment/comment.dart';
import 'package:facebook/services/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../values/api_values.dart';

class TestMe extends StatefulWidget {
  String? idPost;
  TestMe({this.idPost});
  @override
  _TestMeState createState() => _TestMeState(idPost: idPost);
}

class _TestMeState extends State<TestMe> {
  String? idPost;
  _TestMeState({this.idPost});
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  // List filedata = [
  //   {
  //     'name': 'Chuks Okwuenu',
  //     'pic': 'https://picsum.photos/300/30',
  //     'message': 'I love to code',
  //     'date': '2021-01-01 12:00:00'
  //   },
  //   {
  //     'name': 'Biggi Man',
  //     'pic': 'https://www.adeleyeayodeji.com/img/IMG_20200522_121756_834_2.jpg',
  //     'message': 'Very cool',
  //     'date': '2021-01-01 12:00:00'
  //   },
  //   {
  //     'name': 'Tunde Martins',
  //     'pic': 'assets/img/userpic.jpg',
  //     'message': 'Very cool',
  //     'date': '2021-01-01 12:00:00'
  //   },
  //   {
  //     'name': 'Biggi Man',
  //     'pic': 'https://picsum.photos/300/30',
  //     'message': 'Very cool',
  //     'date': '2021-01-01 12:00:00'
  //   },
  // ];
  @override
  void initState() {
    super.initState();
    // Timer.periodic(Duration(milliseconds: 1000), (timer) {
    //   setState(() {});
    // });
  }

  Widget commentChild(String post_id) {
    // final post_id = ModalRoute.of(context)!.settings.arguments as String;
    return SingleChildScrollView(
      child: FutureBuilder(
          future: getComment(ApiValues.TOKEN.toString(), post_id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // return Text("true");
              return Column(children: [
                ListView.builder(
                    // scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data[0].data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () async {
                                // Display the image in large form.
                                print("Comment Clicked");
                              },
                              child: Container(
                                height: 50.0,
                                width: 50.0,
                                decoration: new BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(50))),
                                child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        CommentBox.commentImageParser(
                                            imageURLorPath: snapshot.data[0]
                                                .data[index].poster.avatar)),
                              ),
                            ),
                            title: Text(
                              // snapshot.data[0].data[index].poster.name,
                              snapshot.data[0].data[index].poster.name != null
                                  ? snapshot.data[0].data[index].poster.name
                                  : "null",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle:
                                Text(snapshot.data[0].data[index].comment),
                            trailing: Text(
                                DateFormat(" HH:mm ngà'y' dd/MM/yyyy")
                                    .format(DateTime.fromMillisecondsSinceEpoch(
                                        int.parse(snapshot
                                                .data[0].data[index].created) *
                                            1000))
                                    .toString(),

                                // snapshot.data[0].data[index].created,
                                style: TextStyle(fontSize: 10)),
                          ),
                        )
                      ]);
                    })
              ]);
            } else if (snapshot.hasError) {
              return Column(
                children: const [
                  SizedBox(height: 20),
                  Center(
                      child:
                          Text("No comment", style: TextStyle(fontSize: 17))),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
            ;
          }),
    );
  }
  // return ListView(
  //   children: [
  //     for (var i = 0; i < data.length; i++)
  //       Padding(
  //         padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
  //         child: ListTile(
  //           leading: GestureDetector(
  //             onTap: () async {
  //               // Display the image in large form.
  //               print("Comment Clicked");
  //             },
  //             child: Container(
  //               height: 50.0,
  //               width: 50.0,
  //               decoration: new BoxDecoration(
  //                   color: Colors.blue,
  //                   borderRadius: new BorderRadius.all(Radius.circular(50))),
  //               child: CircleAvatar(
  //                   radius: 50,
  //                   backgroundImage: CommentBox.commentImageParser(
  //                       imageURLorPath: data[i]['pic'])),
  //             ),
  //           ),
  //           title: Text(
  //             data[i]['name'],
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //           ),
  //           subtitle: Text(data[i]['message']),
  //           trailing: Text(data[i]['date'], style: TextStyle(fontSize: 10)),
  //         ),
  //       )
  //   ],
  // );

  @override
  Widget build(BuildContext context) {
    // final post_id = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("Quay lại", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: CommentBox(
          child: commentChild(idPost.toString()),
          userImage: CommentBox.commentImageParser(
              imageURLorPath:
                  ApiValues.AVATAR), //phai lay img cua token user hien tai
          labelText: 'Write a comment...',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              setState(() {
                setComment(ApiValues.TOKEN.toString(), idPost.toString(),
                    commentController.text);
                // filedata.insert(0, value);
                Timer.periodic(Duration(milliseconds: 1000), (timer) {
                  setState(() {});
                });
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
              // setState(() {});
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          sendWidget: Icon(Icons.send_sharp,
              size: 30, color: Colors.blue), //image of users with token
        ),
      ),
    );
  }
}
