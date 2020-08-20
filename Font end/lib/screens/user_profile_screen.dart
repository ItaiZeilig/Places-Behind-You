import 'package:flutter/material.dart';
import 'package:placebehindyou/models/user.dart';
import 'package:placebehindyou/services/user_service.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/userProfile';

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  UserService _userService;
  Map<String, String> _authData = {
    'email': '',
    'role': '',
    'username': '',
    'avatar': '',
  };

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      _userService.getUser.avatar = _authData['avatar'];
      _userService.getUser.role = _authData['role'];
      _userService.getUser.username = _authData['username'];
      _userService.getUser.userId.email = _authData['email'];
      _userService.updateUser(_userService.getUser);
    } catch (error) {
      _showErrorDialog(error.message);
      _isLoading = false;
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _userService = Provider.of<UserService>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: _userService.getUser.userId.email,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      labelText: 'E-Mail',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                    },
                    onSaved: (value) {
                      _authData['email'] = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _userService.getUser.role,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      labelText: 'User Role',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Invalid Role!';
                      }
                    },
                    onSaved: (value) {
                      _authData['role'] = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _userService.getUser.username,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      labelText: 'Username',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Invalid Username!';
                      }
                    },
                    onSaved: (value) {
                      _authData['username'] = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _userService.getUser.avatar,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      labelText: 'Avatar',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Invalid Avatr!';
                      }
                    },
                    onSaved: (value) {
                      _authData['avatar'] = value;
                    },
                  ),
                                            ButtonTheme(
                            minWidth: 300.0,
                            child: RaisedButton(
                              color: Color(0xFFc1b7f3),
                              onPressed: _submit,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
