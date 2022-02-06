import 'package:flutter/material.dart';

//Packages
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/provider.dart';

//Providers
import 'package:chat_app_custom/providers/authentication_provider.dart';

//Services
import 'package:chat_app_custom/services/navigation_service.dart';

//Pages
import 'package:chat_app_custom/pages/splash_page.dart';
import 'package:chat_app_custom/pages/login_page.dart';
import 'package:chat_app_custom/pages/register_page.dart';
import 'package:chat_app_custom/pages/home_page.dart';

void main() {
  runApp(SplashPage(
    key: UniqueKey(),
    onInitializationComplete: () {
      runApp(
        MainApp(),
      );
    },
  ));
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
            create: (BuildContext _context) {
          return AuthenticationProvider();
        })
      ],
      child: MaterialApp(
        title: 'Chatify',
        theme: ThemeData(
          backgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
          scaffoldBackgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(30, 29, 37, 1.0),
          ),
        ),
        navigatorKey: NavigationService.navigationKey,
        initialRoute: '/login',
        routes: {
          '/login': (BuildContext _context) => LoginPage(),
          '/register': (BuildContext _context) => RegisterPage(),
          '/home': (BuildContext _context) => HomePage(),
        },
      ),
    );
  }
}
