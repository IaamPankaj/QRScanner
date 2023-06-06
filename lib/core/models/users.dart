class Users {
  String? name;
  String? number;
  String? code;
  String? userId;
  String? createdAt;
  bool? isProfileAdded;
  String? role;
  String? email;
  String? adminId;

  Users({
    this.name,
    this.number,
    this.code,
    this.userId,
    this.createdAt,
    this.isProfileAdded,
    this.role,
    this.email,
    this.adminId,
  });

  Users.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
    code = json['code'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    isProfileAdded = json['isProfileAdded'];
    role = json['role'];
    email = json['email'];
    adminId = json['admin_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['number'] = number;
    data['code'] = code;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['role'] = role;
    data['email'] = email;
    data['admin_id'] = adminId;
    return data;
  }
}
