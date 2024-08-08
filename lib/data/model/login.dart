class loginModel {
  int? id;
  String? name;
  String? email;
  int? phoneNumber;
  String? emailVerifiedAt;
  int? banned;
  String? fcmToken;
  String? otp;
  int? verified;
  String? createdAt;
  String? updatedAt;

  loginModel(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.emailVerifiedAt,
      this.banned,
      this.fcmToken,
      this.otp,
      this.verified,
      this.createdAt,
      this.updatedAt});

  loginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    emailVerifiedAt = json['email_verified_at'];
    banned = json['banned'];
    fcmToken = json['fcm_token'];
    otp = json['otp'];
    verified = json['verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['banned'] = this.banned;
    data['fcm_token'] = this.fcmToken;
    data['otp'] = this.otp;
    data['verified'] = this.verified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
