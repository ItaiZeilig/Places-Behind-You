import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.userId,
        this.role,
        this.username,
        this.avatar,
    });

    UserId userId;
    String role;
    String username;
    String avatar;

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: UserId.fromJson(json["userId"]),
        role: json["role"],
        username: json["username"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId.toJson(),
        "role": role,
        "username": username,
        "avatar": avatar,
    };
}

class UserId {
    UserId({
        this.domain,
        this.email,
    });

    String domain;
    String email;

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        domain: json["domain"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "domain": domain,
        "email": email,
    };
}
