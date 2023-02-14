import 'package:flutter/foundation.dart';
import '../models/Block.dart';
import '../models/Comment.dart';
import '../models/ListFriend.dart';
import '../models/ListPost.dart';
import '../models/ListRequestFriend.dart';
import '../models/SearchPostById.dart';
import '../models/Register.dart';
import '../models/SearchPostsByKeyword.dart';
import '../models/SuggestFriends.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//***xem danh sach gui loi moi ket ban***
List<ListRequestFriend> parseListRequest(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<ListRequestFriend> listRequest =
      list.map((model) => ListRequestFriend.fromJson(model)).toList();
  return listRequest;
}

Future<List<ListRequestFriend>> getRequestFriend(String token) async {
  final response = await http.post(Uri.parse(
      "https://flutter-hust.onrender.com/it4788/friend/get_requested_friends?token=${token}&index=0&count=500"));
  if (response.statusCode == 200) {
    return compute(parseListRequest, "[" + response.body + "]");
  } else {
    throw Exception("Request Api Error");
  }
}

//***xem danh sach ban be***
List<ListFriend> parseListFriend(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<ListFriend> listRequest =
      list.map((model) => ListFriend.fromJson(model)).toList();
  return listRequest;
}

Future<List<ListFriend>> getListFriend(String token, String id) async {
  final response = await http.post(Uri.parse(
      "https://flutter-hust.onrender.com/it4788/friend/get_user_friends?token=${token}&user_id=${id}&index=0&count=500"));
  if (response.statusCode == 200) {
    return compute(parseListFriend, "[" + response.body + "]");
  } else {
    throw Exception("Request Api Error");
  }
}

//***Block**
Future<void> setBlock(String token, String userId, String type) async {
  final response = await http.post(Uri.parse(
      "https://flutter-hust.onrender.com/it4788/friend/set_block?token=${token}&user_id=${userId}&type=${type}"));
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception("Request Api Error");
  }
}

//***Unfollow**
Future<void> setUnfriend(String token, String userId, String type) async {
  final response = await http.post(Uri.parse(
      "https://flutter-hust.onrender.com/it4788/friend/set_block?token=${token}&user_id=${userId}&type=${type}"));
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception("Request Api Error");
  }
}

//***xem danh sách đã chặn*/
List<Block> parseBlock(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<Block> listRequest = list.map((model) => Block.fromJson(model)).toList();
  return listRequest;
}

Future<List<Block>> getListBlock(String token) async {
  final response = await http.post(Uri.parse(
      "https://flutter-hust.onrender.com/it4788/friend/get_list_blocks?token=${token}&index=0&count=500"));
  if (response.statusCode == 200) {
    return compute(parseBlock, "[" + response.body + "]");
  } else {
    throw Exception("Request Api Error");
  }
}

//***danh sách gợi ý kết bạn */
List<SuggestFriends> parseSuggestFriends(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<SuggestFriends> listRequest =
      list.map((model) => SuggestFriends.fromJson(model)).toList();
  return listRequest;
}

Future<List<SuggestFriends>> getSuggestFriends(String token) async {
  final response = await http.post(Uri.parse(
      "https://flutter-hust.onrender.com/it4788/friend/get_list_suggested_friends?token=${token}&index=1&count=50"));
  if (response.statusCode == 200) {
    return compute(parseSuggestFriends, "[" + response.body + "]");
  } else {
    throw Exception("Request Api Error");
  }
}

//***respone request friends */
Future<void> AcceptFriend(String token, String id, String isAccept) async {
  final response = await http.post(Uri.parse(
      "https://flutter-hust.onrender.com/it4788/friend/set_accept_friend?token=${token}&user_id=${id}&is_accept=${isAccept}"));
}

//**setRequestFriend */
Future<void> setRequestFriend(String token, String id) async {
  final response = await http.post(Uri.parse(
      "https://flutter-hust.onrender.com/it4788/friend/set_request_friend?token=${token}&user_id=${id}"));
}

//***tìm kiếm bài viết */
List<SearchPosts> parseSearchPosts(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<SearchPosts> listRequest =
      list.map((model) => SearchPosts.fromJson(model)).toList();
  return listRequest;
}

Future<List<SearchPosts>> searchPosts(String token, String keyword) async {
  final response = await http.post(Uri.parse(
      "https://flutter-hust.onrender.com/it4788/search/search?token=${token}&index=0&count=500&keyword=${keyword}"));
  if (response.statusCode == 200) {
    return compute(parseSearchPosts, "[" + response.body + "]");
  } else {
    throw Exception("Request Api Error");
  }
}

//***tìm kiếm bài viết qua id*/
List<PostById> parseSearchPostById(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<PostById> listRequest =
      list.map((model) => PostById.fromJson(model)).toList();
  return listRequest;
}

Future<List<PostById>> searchPostById(String token, String id) async {
  final response = await http.post(Uri.parse(
      "https://flutter-hust.onrender.com/it4788/post/get_post?token=${token}&id=${id}"));
  if (response.statusCode == 200) {
    return compute(parseSearchPostById, "[" + response.body + "]");
  } else {
    throw Exception("Request Api Error");
  }
}

//**setRequestFriend */
Future<void> addAPost(String token, String described) async {
  final response = await http.post(Uri.parse(
      "https://flutter-hust.onrender.com/it4788/post/add_post?token=${token}&described=${described}&status=hạnh phúc"));
}

//***xem danh sách bài đăng*/
List<ListPost> parseListPost(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<ListPost> listRequest =
      list.map((model) => ListPost.fromJson(model)).toList();
  return listRequest;
}

Future<List<ListPost>> getListPost(String token) async {
  final response = await http.post(Uri.parse(
      "https://flutter-hust.onrender.com/it4788/post/get_list_posts?token=${token}&last_id=0&index=0&count=20"));
  // if (response.statusCode == 200) {
  return compute(parseListPost, "[" + response.body + "]");
  // } else {
  //   throw Exception("Request Api Error");
  // }
}

//**get comment */
List<Comment> parseComment(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<Comment> listRequest =
      list.map((model) => Comment.fromJson(model)).toList();
  return listRequest;
}

Future<List<Comment>> getComment(String token, String id) async {
  final response = await http.post(Uri.parse(
      "https://flutter-hust.onrender.com/it4788/comment/get_comment?token=${token}&id=${id}&index=0&count=20"));
  if (response.statusCode == 200) {
    return compute(parseComment, "[" + response.body + "]");
  } else {
    throw Exception("Request Api Error");
  }
  // return [];
}

//**set comment */

Future<void> setComment(String token, String id, String comment) async {
  final response = await http.post(Uri.parse(
      "https://flutter-hust.onrender.com/it4788/comment/set_comment?token=${token}&id=${id}&comment=${comment}&index=0&count=50"));
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception("Request Api Error");
  }
}

//**set like */
Future<void> setLike(String token, String idPost) async {
  final response = await http.post(Uri.parse(
      "https://flutter-hust.onrender.com/it4788/like/like?token=${token}&id=${idPost}"));
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception("Request Api Error");
  }
}

Future<void> deletePost(String token, String id) async {
  final response = await http.post(Uri.parse(
      "https://flutter-hust.onrender.com/it4788/post/delete_post?token=${token}&id=${id}"));
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception("Request Api Error");
  }
}

Future<void> editPost(String token, String idPost, String text) async {
  final response = await http.post(Uri.parse(
      "https://flutter-hust.onrender.com/it4788/post/edit_post?token=${token}&id=${idPost}&described=${text}"));
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception("Request Api Error");
  }
}
