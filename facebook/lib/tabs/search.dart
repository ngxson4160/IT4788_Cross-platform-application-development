import 'dart:async';

import 'package:flutter/material.dart';

import '../models/SearchPostsByKeyword.dart';
import '../services/remote_service.dart';
import '../values/api_values.dart';
import '../values/app_colors.dart';
import '../widgets/post_widget_search.dart';
import '../widgets/separator_widget.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // final formKey = GlobalKey<FormState>();
  TextEditingController keyword = TextEditingController();
  bool isSearch = false;
  Future<List<SearchPosts>>? _test;
  String ischeck = "";
  @override
  void initState() {
    super.initState();
    // _test = searchPosts(
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzZTNkNTE4ZTZhNjg4MDA0NWI5MGNlOCIsImRhdGVMb2dpbiI6IjIwMjMtMDItMTNUMTA6MDQ6MzIuMjIzWiIsImlhdCI6MTY3NjI4MjY3MiwiZXhwIjoxNjc2MzY5MDcyfQ.mfaLTdF8svgEHJD0-LAdE61IBMkYMjDJsBSiqPU1RSQ",
    //     keyword.text.toString());
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Container(
            height: screenWidth * 0.09,
            width: screenWidth * 0.7,
            child: TextFormField(
              controller: keyword,
              textInputAction: TextInputAction.search,
              onEditingComplete: () {
                FocusManager.instance.primaryFocus?.unfocus();
                _test = searchPosts(
                    ApiValues.TOKEN.toString(), keyword.text.toString());
                isSearch = true;
                setState(() {});
                // Timer.periodic(Duration(milliseconds: 1000), (timer) {
                //   setState(() {});
                // });
              },
              autofocus: true,
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
                hintText: "Tìm kiếm trên Facebook",
                contentPadding: EdgeInsets.all(0),
                hintStyle: TextStyle(fontSize: 17, color: Colors.grey[500]),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 2.0),
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
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: AppColors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: AppColors.white,
        ),
        body: SingleChildScrollView(
          child: Visibility(
              visible: isSearch,
              child: FutureBuilder(
                  future: _test,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(children: [
                        ListView.builder(
                            // scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data[0].data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(children: [
                                PostWidget1(
                                  idPost: snapshot.data[0].data[index].id,
                                  image: snapshot.data[0].data[index].image,
                                  like: snapshot.data[0].data[index].like,
                                  comment: snapshot.data[0].data[index].comment,
                                  is_liked:
                                      snapshot.data[0].data[index].isLiked,
                                  idAuthor:
                                      snapshot.data[0].data[index].author.id,
                                  described:
                                      snapshot.data[0].data[index].described,
                                ),
                                // Text(
                                //     snapshot.data[0].data[index].id.toString()),
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
                  })),
        ));
  }
}
