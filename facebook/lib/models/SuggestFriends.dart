class SuggestFriends {
  String? code;
  String? message;
  Data? data;

  SuggestFriends({this.code, this.message, this.data});

  SuggestFriends.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? total;
  List<ListUsers>? listUsers;

  Data({this.total, this.listUsers});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['list_users'] != null) {
      listUsers = <ListUsers>[];
      json['list_users'].forEach((v) {
        listUsers!.add(new ListUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.listUsers != null) {
      data['list_users'] = this.listUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListUsers {
  String? userId;
  String? username;
  String? avatar;
  String? sameFriends;

  ListUsers({this.userId, this.username, this.avatar, this.sameFriends});

  ListUsers.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    avatar = json['avatar'];
    sameFriends = json['same_friends'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['same_friends'] = this.sameFriends;
    return data;
  }
}
