import 'package:flutter/material.dart';
import 'package:placebehindyou/models/newUserDetails.dart';
import 'package:placebehindyou/screens/home_screen.dart';
import 'package:placebehindyou/services/user_service.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AuthMode _authMode = AuthMode.Login;
  UserService userService;
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
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
      if (_authMode == AuthMode.Login) {
        // Login User
        await userService.login(_authData['email'].trim());
      } else {
        // Sign user up
       await userService.createUser(
          NewUserDetails(
            email: _authData['email'].trim(),
            avatar: _authData['avatar'],
            role: _authData['role'].toUpperCase(),
            username: _authData['username'].trim(),
          )
        );
      }
    } catch (error) {
      _showErrorDialog(error.message);
      setState(() {
        _formKey.currentState.reset();
      });
    }
    setState(() {
      _isLoading = false;
      _formKey.currentState.reset();
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    userService = Provider.of<UserService>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(40),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
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
                        if (_authMode == AuthMode.Signup)
                          Column(
                            children: <Widget>[
                              TextFormField(
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  labelText: 'User Role',
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) => value.isEmpty
                                    ? 'User Role is not valid'
                                    : null,
                                onSaved: (value) {
                                  _authData['role'] = value;
                                },
                              ),
                              TextFormField(
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  labelText: 'Username',
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) => value.isEmpty
                                    ? 'Username is not valid'
                                    : null,
                                onSaved: (value) {
                                  _authData['username'] = value;
                                },
                              ),
                              TextFormField(
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  labelText: 'Avatar',
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) => value.isEmpty
                                    ? 'Avatar is not valid'
                                    : null,
                                onSaved: (value) {
                                  _authData['avatar'] = value;
                                },
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 25,
                        ),
                        if (_isLoading)
                          CircularProgressIndicator()
                        else
                          ButtonTheme(
                            minWidth: 300.0,
                            child: RaisedButton(
                              color: Color(0xFFc1b7f3),
                              onPressed: _submit,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                '${_authMode == AuthMode.Login ? 'LOGIN' : 'SIGNUP'}',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            MaterialButton(
                              onPressed: _switchAuthMode,
                              splashColor: Theme.of(context).primaryColor,
                              child: Text(
                                'SignUp',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
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
