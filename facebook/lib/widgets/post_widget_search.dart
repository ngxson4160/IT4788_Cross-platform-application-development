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

class PostWidget1 extends StatefulWidget {
  String? idPost;
  // String? avatar;
  String? like;
  List<String>? image;
  String? comment;
  String? is_liked;
  String? idAuthor;
  String? described;

  PostWidget1({
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
  State<PostWidget1> createState() => _PostWidget1State(
        // idPost: idPost,
        like: like,
        image: image,
        comment: comment,
        // is_liked: is_liked,
        // idAuthor: idAuthor,
        // described: described
      );
}

class _PostWidget1State extends State<PostWidget1> {
  // String? idPost;
  String? avatar;
  String? like;
  List<String>? image;
  String? comment;
  // String? is_liked;
  // String? idAuthor;
  // String? described;

  _PostWidget1State({
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
            return Text(widget.idPost.toString());
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
                        Text(name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17.0)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(like! + " likes"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('${comment} comments  •  '), //total coment
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
}
