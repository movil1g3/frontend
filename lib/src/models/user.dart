import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String? name;
  String? lastname;
  String? phone;
  String? email;
  String? password;
  String? photo;
  String? sessionToken;

  User({
    this.id,
    this.name,
    this.lastname,
    this.phone,
    this.email,
    this.password,
    this.photo,
    this.sessionToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    lastname: json["lastname"],
    phone: json["phone"],
    email: json["email"],
    password: json["password"],
    photo: json["photo"],
    sessionToken: json["session_token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "lastname": lastname,
    "phone": phone,
    "email": email,
    "password": password,
    "photo": photo,
    "session_token": sessionToken,
  };
}
