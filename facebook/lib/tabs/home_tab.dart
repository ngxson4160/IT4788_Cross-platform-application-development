import 'dart:async';

import 'package:facebook/widgets/write_something_widget.dart';
import 'package:facebook/widgets/separator_widget.dart';
import 'package:facebook/widgets/post_widget_home.dart';
import 'package:facebook/widgets/stories_widget.dart';
import 'package:facebook/widgets/online_widget.dart';
import 'package:facebook/models/post.dart';
import 'package:flutter/material.dart';

import '../services/remote_service.dart';
import '../values/api_values.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  // void initState() {
  //   super.initState();
  //   Timer.periodic(Duration(milliseconds: 50), (timer) {
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          WriteSomethingWidget(),
          SeparatorWidget(),
          OnlineWidget(),
          SeparatorWidget(),
          StoriesWidget(),
          // for (Post post in posts)
          //   Column(
          //     children: <Widget>[
          //       SeparatorWidget(),
          //       // PostWidget(post: post),
          //     ],
          //   ),
          SeparatorWidget(),
          FutureBuilder(
              future: getListPost(ApiValues.TOKEN.toString()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(children: [
                    ListView.builder(
                        // scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data[0].data.posts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(children: [
                            PostWidget(
                              idPost: snapshot.data[0].data.posts[index].id,
                              image: snapshot.data[0].data.posts[index].image,
                              like: snapshot.data[0].data.posts[index].like,
                              comment:
                                  snapshot.data[0].data.posts[index].comment,
                              is_liked:
                                  snapshot.data[0].data.posts[index].isLiked,
                              idAuthor:
                                  snapshot.data[0].data.posts[index].author.id,
                              described:
                                  snapshot.data[0].data.posts[index].described,
                            ),
                            // Text(snapshot.data[0].data.posts[index].described
                            //     .toString()),
                            // SeparatorWidget(),
                          ]);
                        })
                  ]);
                } else if (snapshot.hasError) {
                  return Column(
                    children: const [
                      SizedBox(height: 20),
                      Center(
                          child: Text("Không tìm thấy kết quả phù hợp.",
                              style: TextStyle(fontSize: 17))),
                    ],
                  );
                } else {
                  return Column(
                    children: const [
                      SizedBox(height: 20),
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }
}
