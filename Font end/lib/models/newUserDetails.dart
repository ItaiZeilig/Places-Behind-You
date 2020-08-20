import 'dart:convert';

NewUserDetails newUserDetailsFromJson(String str) => NewUserDetails.fromJson(json.decode(str));

String newUserDetailsToJson(NewUserDetails data) => json.encode(data.toJson());

class NewUserDetails {
    NewUserDetails({
        this.email,
        this.role,
        this.username,
        this.avatar,
    });

    String email;
    String role;
    String username;
    String avatar;

    factory NewUserDetails.fromJson(Map<String, dynamic> json) => NewUserDetails(
        email: json["email"],
        role: json["role"],
        username: json["username"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "role": role,
        "username": username,
        "avatar": avatar,
    };
}
