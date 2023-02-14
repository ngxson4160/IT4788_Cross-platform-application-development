import 'package:flutter/material.dart';

import '../pages/login_page.dart';
import '../pages/post.dart';
import '../values/api_values.dart';
import '../values/app_colors.dart';

class WriteSomethingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // CircleAvatar(
                //   radius: 28.0,
                //   backgroundImage: NetworkImage(ApiValues.AVATAR.toString()),
                // ),
                CircleAvatar(
                  radius: 23.0,
                  backgroundImage: NetworkImage(ApiValues.AVATAR.toString()),
                ),
                // SizedBox(width: 7.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  height: 40.0,
                  width: MediaQuery.of(context).size.width / 1.7,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Bạn đang nghĩ gì?",
                          contentPadding: EdgeInsets.all(0),
                          hintStyle:
                              TextStyle(fontSize: 17, color: AppColors.gray),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0,
                            ),
                          ),
                        ),
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostPage()));
                        })),
                    // child: TextFormField(
                    //     decoration: const InputDecoration(
                    //         hintText: "Write Something Here ...",
                    //         alignLabelWithHint: true),
                    //  onTap: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => PostPage()));
                    // })
                    // child: Text('Write something here...',
                    //     style: TextStyle(color: Colors.grey)),
                  ),
                ),
                // child: Text('Write something here...',
                //     style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
