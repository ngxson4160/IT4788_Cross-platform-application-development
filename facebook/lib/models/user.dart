class User {
  String? code;
  String? message;
  String? details;
  Data? data;

  User({this.code, this.message, this.details, this.data});

  User.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    details = json['details'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['details'] = this.details;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? username;
  String? token;
  String? avatar;
  String? active;

  Data({this.id, this.username, this.token, this.avatar, this.active});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    token = json['token'];
    avatar = json['avatar'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['token'] = this.token;
    data['avatar'] = this.avatar;
    data['active'] = this.active;
    return data;
  }
}
