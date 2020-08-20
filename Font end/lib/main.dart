import 'package:flutter/material.dart';
import 'package:placebehindyou/screens/create_element_screen.dart';
import 'package:placebehindyou/screens/home_screen.dart';
import 'package:placebehindyou/screens/map_screen.dart';
import 'package:placebehindyou/screens/search_element_byID.dart';
import 'package:placebehindyou/screens/single_element_screen.dart';
import 'package:placebehindyou/screens/user_profile_screen.dart';
import 'package:placebehindyou/services/element_service.dart';
import 'package:placebehindyou/services/user_service.dart';
import 'package:provider/provider.dart';
import './screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserService(),
        ),
        ChangeNotifierProvider.value(
          value: ElementService(),
        ),
      ],
      child: Consumer<UserService>(
        builder: (ctx, userService, _) => MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
              // Define the default brightness and colors.
              brightness: Brightness.light,
              primaryColor: Color(0xFF7f70e7),
              accentColor: Color(0xFFB9C4E4),
            ),
            home: userService.handleAuth(),
            routes: {
              LoginScreen.routeName: (ctx) => LoginScreen(),
              HomeScreen.routeName: (ctx) => HomeScreen(),
              UserProfileScreen.routeName: (ctx) => UserProfileScreen(),
              CreateElementScreen.routeName: (ctx) => CreateElementScreen(),
              SearchElementByIDScreen.routeName: (ctx) =>
                  SearchElementByIDScreen(),
              MapScreen.routeName: (ctx) => MapScreen(),
            }),
      ),
    );
  }
}
