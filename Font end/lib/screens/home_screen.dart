import 'package:flutter/material.dart';
import 'package:placebehindyou/screens/create_element_screen.dart';
import 'package:placebehindyou/screens/map_screen.dart';
import 'package:placebehindyou/screens/search_element_byID.dart';
import 'package:placebehindyou/screens/user_profile_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                MaterialButton(
                  onPressed: () => {
                    Navigator.of(context).pushNamed(UserProfileScreen.routeName)
                  },
                  splashColor: Theme.of(context).primaryColor,
                  child: Text(
                    'User Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () => {
                    Navigator.of(context)
                        .pushNamed(CreateElementScreen.routeName)
                  },
                  splashColor: Theme.of(context).primaryColor,
                  child: Text(
                    'Create Element',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () => {
                    Navigator.of(context)
                        .pushNamed(SearchElementByIDScreen.routeName)
                  },
                  splashColor: Theme.of(context).primaryColor,
                  child: Text(
                    'Search Element BY ID',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () => {
                    Navigator.of(context)
                        .pushNamed(MapScreen.routeName)
                  },
                  splashColor: Theme.of(context).primaryColor,
                  child: Text(
                    'Map Screen',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
