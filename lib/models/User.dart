// ignore_for_file: file_names
class User {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phoneNumber;
  String? avatar;
  String? roleId;
  DateTime? createdAt;
  UserRole? userRole;
  String? accessToken;

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phoneNumber,
    this.avatar,
    this.roleId,
    this.createdAt,
    this.userRole,
    this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phone_number"],
        avatar: json["avatar"] ?? "",
        roleId: json["role_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        userRole: json["userRole"] == null
            ? null
            : UserRole.fromJson(json["userRole"]),
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "phone_number": phoneNumber,
        "avatar": avatar,
        "role_id": roleId,
        "created_at": createdAt?.toIso8601String(),
        "userRole": userRole?.toJson(),
        "accessToken": accessToken,
      };
}

class UserRole {
  String? roleId;
  String? role;

  UserRole({
    this.roleId,
    this.role,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
        roleId: json["role_id"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "role_id": roleId,
        "role": role,
      };
}
