
import 'package:flutter/material.dart';
import 'package:placebehindyou/screens/home_screen.dart';
import 'package:placebehindyou/screens/login_screen.dart';
import '../models/user.dart';
import '../models/newUserDetails.dart';
import 'package:http/http.dart' as http;

class UserService extends ChangeNotifier {
  final String userURL = 'http://10.100.102.5:8083/acs/users';
  final String domain = '2020b.or.zaidman.placebehindyou';
  User _user;

  User get getUser => _user;

  Future<void> createUser(NewUserDetails newUser) async {
    final http.Response response = await http.post(userURL,
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        },
        body: newUserDetailsToJson(newUser));

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      _user = userFromJson(response.body);
      notifyListeners();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load User');
    }
  }

  Future<void> login(String email) async {
    final http.Response response = await http.get(
      userURL+"/login/${domain}/${email}",
      headers: {
        "accept": "application/json",
        "content-type": "application/json"
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      print(response.body);
      _user = userFromJson(response.body);
      notifyListeners();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load User');
    }
  }

    handleAuth() {
      if(_user != null){
        return HomeScreen();
      }else{
        return LoginScreen();
      }
    }

  Future<void> updateUser(User user) async{
    final http.Response response = await http.put(
      userURL+"/${getUser.userId.domain}/${getUser.userId.email}",
      headers: {
        "content-type": "application/json"
      },
      body: userToJson(user)
    );
    print(response.statusCode);
  }
}
