import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/auth_screen.dart';
import './screens/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final initialization =
        Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    return FutureBuilder<FirebaseApp>(
        future: initialization,
        builder:
            (BuildContext context, AsyncSnapshot<FirebaseApp> appSnapshot) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              backgroundColor: Colors.pink,
              buttonTheme: ButtonTheme.of(context).copyWith(
                  buttonColor: Colors.pink,
                  textTheme: ButtonTextTheme.primary,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
                  .copyWith(secondary: Colors.deepPurple),
            ),
            home: appSnapshot.connectionState == ConnectionState.waiting
                ? const SplashScreen()
                : StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder:
                        (BuildContext context, AsyncSnapshot userSnapshot) {
                      return (userSnapshot.hasData)
                          ? const ChatScreen()
                          : const AuthScreen();
                    },
                  ),
          );
        });
  }
}
