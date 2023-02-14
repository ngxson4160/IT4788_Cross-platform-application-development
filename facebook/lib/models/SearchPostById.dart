class PostById {
  String? code;
  String? message;
  Data? data;

  PostById({this.code, this.message, this.data});

  PostById.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? described;
  String? created;
  String? modified;
  String? like;
  String? comment;
  String? isLiked;
  List<Images>? image;
  Null? video;
  Author? author;
  String? state;
  String? isBlocked;
  String? canEdit;
  String? canComment;

  Data(
      {this.id,
      this.described,
      this.created,
      this.modified,
      this.like,
      this.comment,
      this.isLiked,
      this.image,
      this.video,
      this.author,
      this.state,
      this.isBlocked,
      this.canEdit,
      this.canComment});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    described = json['described'];
    created = json['created'];
    modified = json['modified'];
    like = json['like'];
    comment = json['comment'];
    isLiked = json['is_liked'];
    if (json['image'] != null) {
      image = <Images>[];
      json['image'].forEach((v) {
        image!.add(new Images.fromJson(v));
      });
    }
    video = json['video'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    state = json['state'];
    isBlocked = json['is_blocked'];
    canEdit = json['can_edit'];
    canComment = json['can_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['described'] = this.described;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['like'] = this.like;
    data['comment'] = this.comment;
    data['is_liked'] = this.isLiked;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    data['video'] = this.video;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['state'] = this.state;
    data['is_blocked'] = this.isBlocked;
    data['can_edit'] = this.canEdit;
    data['can_comment'] = this.canComment;
    return data;
  }
}

class Images {
  String? id;
  String? url;

  Images({this.id, this.url});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}

class Author {
  String? id;
  String? name;
  String? avatar;

  Author({this.id, this.name, this.avatar});

  Author.fromJson(Map<String, dynamic> json) {
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
