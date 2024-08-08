class regModel {
  String? name;
  String? email;
  bool? verified;
  String? updatedAt;
  String? createdAt;
  int? id;

  regModel(
      {this.name,
      this.email,
      this.verified,
      this.updatedAt,
      this.createdAt,
      this.id});

  regModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    verified = json['verified'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['verified'] = this.verified;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
