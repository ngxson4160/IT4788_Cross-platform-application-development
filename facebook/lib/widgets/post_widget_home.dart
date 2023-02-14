import 'dart:async';
import 'dart:convert';

import 'package:facebook/models/SearchPostsByKeyword.dart';
import 'package:facebook/pages/comment.dart';
import 'package:facebook/pages/test.dart';
import 'package:facebook/widgets/separator_widget.dart';
import 'package:flutter/material.dart';
import 'package:facebook/models/post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/ListPost.dart';
import '../services/remote_service.dart';
import '../values/api_values.dart';
import '../values/app_colors.dart';

class PostWidget extends StatefulWidget {
  String? idPost;
  // String? avatar;
  String? like;
  List<Images>? image;
  String? comment;
  String? is_liked;
  String? idAuthor;
  String? described;

  PostWidget({
    this.idPost,
    // this.avatar,
    this.like,
    this.image,
    this.comment,
    this.is_liked,
    this.idAuthor,
    this.described,
  });

  @override
  // ignore: no_logic_in_create_state
  State<PostWidget> createState() => _PostWidgetState(
        // idPost: idPost,
        like: like,
        image: image,
        comment: comment,
        // is_liked: is_liked,
        // idAuthor: idAuthor,
        // described: described
      );
}

class _PostWidgetState extends State<PostWidget> {
  // String? idPost;
  String? avatar;
  String? like;
  List<Images>? image;
  String? comment;
  // String? is_liked;
  // String? idAuthor;
  // String? described;

  _PostWidgetState({
    // this.idPost,
    this.like,
    this.image,
    this.comment,
    // this.is_liked,
    // this.idAuthor,
    // this.described,
  });

  String name = "Facebook User";
  String time = "Time";
  String? check;

  @override
  void initState() {
    super.initState();
    // getCheck();
    // Timer.periodic(Duration(milliseconds: 1000), (timer) {
    //   setState(() {});
    // });
    // setState(() {});
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getInfo(ApiValues.TOKEN.toString(), widget.idAuthor.toString()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == "blocked")
              return const SizedBox.shrink();
            else {
              // return Text(snapshot.data);
              return Container(
                child: FutureBuilder(
                    future: searchPostById(
                        ApiValues.TOKEN.toString(), widget.idPost.toString()),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return elementPost(
                            context,
                            snapshot.data[0].data.author.avatar.toString(),
                            snapshot.data[0].data.author.name.toString(),
                            snapshot.data[0].data.created.toString(),
                            widget.described.toString());
                      } else if (snapshot.hasError) {
                        return Text("Không tìm thấy.");
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
              );
            }
          } else if (snapshot.hasError) {
            return const SizedBox.shrink();
            // return Text(widget.idPost.toString());
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  Container elementPost(BuildContext context, String avatar, String name,
      String time, String described) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(avatar),
                      radius: 20.0,
                    ),
                    SizedBox(width: 7.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0)),
                            Visibility(
                                visible: (ApiValues.ID == widget.idAuthor),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 150),
                                  child: GestureDetector(
                                      onTap: () {
                                        showAlertDialog(
                                            context, widget.idPost.toString());
                                      },
                                      child: const Text("•••",
                                          style: TextStyle(fontSize: 20))),
                                )),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Text(DateFormat("'Đăng lúc' HH:mm ngà'y' dd/MM/yyyy")
                            .format(DateTime.fromMillisecondsSinceEpoch(
                                int.parse(time) * 1000)))
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(described, style: TextStyle(fontSize: 18.0)),
                  ),
                ),
                SizedBox(height: 10.0),
                // ListView(children: <Widget>[
                //   Image.network(image![0].url.toString())
                // ]),

                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // Icon(FontAwesomeIcons.thumbsUp,
                        //     size: 15.0, color: Colors.blue),
                        Text(like! + " likes"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('${widget.comment} comments  •  '), //total coment
                        Text('0 shares'), //total share
                      ],
                    ),
                  ],
                ),
                Divider(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (() {
                              setLike(ApiValues.TOKEN.toString(),
                                  widget.idPost.toString());
                            }),
                            child: Row(
                              children: [
                                Icon(FontAwesomeIcons.thumbsUp,
                                    size: 20.0,
                                    color: (widget.is_liked == "1")
                                        ? Colors.blue
                                        : Colors.black),
                                SizedBox(width: 5.0),
                                Text('Like',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: (widget.is_liked == "1")
                                            ? Colors.blue
                                            : Colors.black)),
                              ],
                            ),
                          ),
                          // SizedBox(width: 5.0),
                          // Text('Like',
                          //     style: TextStyle(
                          //         fontSize: 14.0,
                          //         color: (widget.is_liked == "1")
                          //             ? Colors.blue
                          //             : Colors.black)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TestMe(idPost: widget.idPost)));
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.commentAlt, size: 20.0),
                          SizedBox(width: 5.0),
                          Text('Comment', style: TextStyle(fontSize: 14.0)),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.share, size: 20.0),
                        SizedBox(width: 5.0),
                        Text('Share', style: TextStyle(fontSize: 14.0)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          SeparatorWidget(),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context, String idPost) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var heightAppBar = AppBar().preferredSize.height;
    double heightDialog = screenHeight * 0.2;
    // set up the buttons

    Widget block = Container(
        height: heightDialog * 0.5,
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.15,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 0, left: 0, right: screenWidth * 0.02),
                child:
                    Icon(Icons.edit_outlined, size: 35.0, color: Colors.black),
                // child: Image.asset("assets/images/block.png"),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text("Chỉnh sửa bài viết",
                            style: TextStyle(
                                color: AppColors.black, fontSize: 18))),
                    // Align(
                    //   alignment: AlignmentDirectional.centerStart,
                    //   child: Text.rich(
                    //       maxLines: 2,
                    //       overflow: TextOverflow.ellipsis,
                    //       TextSpan(
                    //           text: name.toString() +
                    //               ' sẽ không thể nhìn thấy bạn hoặc liên hệ với bạn trên Facebook',
                    //           style: TextStyle(
                    //               color: AppColors.gray, fontSize: 18))),
                    // )
                  ],
                ),
              ),
            ),
          ],
        ));

    Widget unfriend = Container(
        height: heightDialog * 0.4,
        child: Row(children: [
          Container(
            width: screenWidth * 0.15,
            child: Padding(
              padding:
                  EdgeInsets.only(top: 0, left: 0, right: screenWidth * 0.02),
              child: Icon(Icons.delete_outlined, size: 35.0, color: Colors.red),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.0),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.035),
                  const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('Xóa bài viết',
                          style:
                              TextStyle(color: AppColors.red, fontSize: 18))),

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
              // GestureDetector(
              //   onTap: () {},
              //   child: Padding(
              //     padding: EdgeInsets.only(bottom: screenHeight * 0.0),
              //     child: seeFriends,
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {},
              //   child: Padding(
              //     padding: EdgeInsets.only(bottom: screenHeight * 0.0),
              //     child: message,
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {},
              //   child: Padding(
              //     padding: EdgeInsets.only(bottom: screenHeight * 0.0),
              //     child: unfollow,
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  // setBlock(ApiValues.TOKEN.toString(), id.toString(), "0");
                  // Navigator.of(context, rootNavigator: true).pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.0),
                  child: block,
                ),
              ),
              GestureDetector(
                onTap: () {
                  deletePost(ApiValues.TOKEN.toString(), idPost.toString());
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
