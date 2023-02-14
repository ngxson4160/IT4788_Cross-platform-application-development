class SearchPosts {
  String? code;
  String? message;
  String? details;
  List<Data>? data;

  SearchPosts({this.code, this.message, this.details, this.data});

  SearchPosts.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    details = json['details'];
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
    data['details'] = this.details;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  List<String>? image;
  String? like;
  String? comment;
  String? isLiked;
  Author? author;
  String? described;

  Data(
      {this.id,
      this.image,
      this.like,
      this.comment,
      this.isLiked,
      this.author,
      this.described});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'].cast<String>();
    like = json['like'];
    comment = json['comment'];
    isLiked = json['is_liked'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    described = json['described'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['like'] = this.like;
    data['comment'] = this.comment;
    data['is_liked'] = this.isLiked;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['described'] = this.described;
    return data;
  }
}

class Author {
  String? id;

  Author({this.id});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}



// class SearchPosts {
//   String? code;
//   String? message;
//   String? details;
//   Data? data;

//   SearchPosts({this.code, this.message, this.details, this.data});

//   SearchPosts.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     message = json['message'];
//     details = json['details'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['message'] = this.message;
//     data['details'] = this.details;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   String? id;
//   String? described;
//   String? created;
//   String? modified;
//   String? like;
//   String? comment;
//   String? isLiked;
//   List<Image>? image;
//   Null? video;
//   Author? author;
//   String? state;
//   String? isBlocked;
//   String? canEdit;
//   String? canComment;

//   Data(
//       {this.id,
//       this.described,
//       this.created,
//       this.modified,
//       this.like,
//       this.comment,
//       this.isLiked,
//       this.image,
//       this.video,
//       this.author,
//       this.state,
//       this.isBlocked,
//       this.canEdit,
//       this.canComment});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     described = json['described'];
//     created = json['created'];
//     modified = json['modified'];
//     like = json['like'];
//     comment = json['comment'];
//     isLiked = json['is_liked'];
//     if (json['image'] != null) {
//       image = <Image>[];
//       json['image'].forEach((v) {
//         image!.add(new Image.fromJson(v));
//       });
//     }
//     video = json['video'];
//     author =
//         json['author'] != null ? new Author.fromJson(json['author']) : null;
//     state = json['state'];
//     isBlocked = json['is_blocked'];
//     canEdit = json['can_edit'];
//     canComment = json['can_comment'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['described'] = this.described;
//     data['created'] = this.created;
//     data['modified'] = this.modified;
//     data['like'] = this.like;
//     data['comment'] = this.comment;
//     data['is_liked'] = this.isLiked;
//     if (this.image != null) {
//       data['image'] = this.image!.map((v) => v.toJson()).toList();
//     }
//     data['video'] = this.video;
//     if (this.author != null) {
//       data['author'] = this.author!.toJson();
//     }
//     data['state'] = this.state;
//     data['is_blocked'] = this.isBlocked;
//     data['can_edit'] = this.canEdit;
//     data['can_comment'] = this.canComment;
//     return data;
//   }
// }

// class Image {
//   String? id;
//   String? url;

//   Image({this.id, this.url});

//   Image.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     url = json['url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['url'] = this.url;
//     return data;
//   }
// }

// class Author {
//   String? id;
//   String? name;
//   String? avatar;

//   Author({this.id, this.name, this.avatar});

//   Author.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     avatar = json['avatar'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['avatar'] = this.avatar;
//     return data;
//   }
// }
