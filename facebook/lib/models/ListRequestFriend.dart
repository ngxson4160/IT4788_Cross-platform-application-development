class ListRequestFriend {
  String? code;
  String? message;
  String? details;
  Data? data;

  ListRequestFriend({this.code, this.message, this.details, this.data});

  ListRequestFriend.fromJson(Map<String, dynamic> json) {
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
  List<Request>? request;
  String? total;

  Data({this.request, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['request'] != null) {
      request = <Request>[];
      json['request'].forEach((v) {
        request!.add(new Request.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.request != null) {
      data['request'] = this.request!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Request {
  String? id;
  String? username;
  String? avatar;
  String? sameFriends;
  String? created;

  Request(
      {this.id, this.username, this.avatar, this.sameFriends, this.created});

  Request.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    avatar = json['avatar'];
    sameFriends = json['same_friends'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['same_friends'] = this.sameFriends;
    data['created'] = this.created;
    return data;
  }
}
