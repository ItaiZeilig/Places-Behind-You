import 'package:flutter/material.dart';
import 'package:placebehindyou/services/element_service.dart';
import 'package:placebehindyou/services/user_service.dart';
import 'package:provider/provider.dart';

class SearchElementByIDScreen extends StatefulWidget {
  static const routeName = '/searchElementByID';

  @override
  _SearchElementByIDScreenState createState() => _SearchElementByIDScreenState();
}

class _SearchElementByIDScreenState extends State<SearchElementByIDScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  UserService _userService;
  ElementService _elementService;

  Map<String, dynamic> _authData = {
    'id': '',
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
      _elementService.searchElementByID(
          _userService.getUser.userId.email, _authData['id']);
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
    _elementService = Provider.of<ElementService>(context);
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
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      labelText: 'Element ID',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Invalid Element ID!';
                      }
                    },
                    onSaved: (value) {
                      _authData['id'] = value;
                    },
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
                          'Search',
                          style: TextStyle(fontSize: 20, color: Colors.white),
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
