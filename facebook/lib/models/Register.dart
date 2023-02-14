class Register {
  String? code;
  String? message;
  String? details;
  Data? data;

  Register({this.code, this.message, this.details, this.data});

  Register.fromJson(Map<String, dynamic> json) {
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
  String? phoneNumber;
  String? verifyCode;
  String? isVerified;

  Data({this.id, this.phoneNumber, this.verifyCode, this.isVerified});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    verifyCode = json['verifyCode'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phoneNumber'] = this.phoneNumber;
    data['verifyCode'] = this.verifyCode;
    data['isVerified'] = this.isVerified;
    return data;
  }
}
