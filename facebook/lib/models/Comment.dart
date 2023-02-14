//

class Comment {
  String? code;
  String? message;
  List<Data>? data;

  Comment({this.code, this.message, this.data});

  Comment.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? comment;
  String? created;
  Poster? poster;
  String? isBlocked;

  Data({this.id, this.comment, this.created, this.poster, this.isBlocked});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    created = json['created'];
    poster =
        json['poster'] != null ? new Poster.fromJson(json['poster']) : null;
    isBlocked = json['is_blocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['created'] = this.created;
    if (this.poster != null) {
      data['poster'] = this.poster!.toJson();
    }
    data['is_blocked'] = this.isBlocked;
    return data;
  }
}

class Poster {
  String? id;
  String? name;
  String? avatar;

  Poster({this.id, this.name, this.avatar});

  Poster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    return data;
  }
}
