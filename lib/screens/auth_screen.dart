import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthState();
}

class _AuthState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  // TODO: use scaffoldmessager and remove context
  void _authenticateUser({String email, String userName, String password, AuthMode authMode, BuildContext ctx}) async {
    AuthResult authResult;

    setState(() {
      _isLoading = true;
    });

    try {
      if (authMode == AuthMode.logIn) {
        authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      } else if (authMode == AuthMode.signUp) {
        authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        await Firestore.instance.collection('users').document(authResult.user.uid).setData({
          'userName': userName,
          'email': email,
          'userId':
        });
      }

    } on PlatformException catch (err) {
      String message = 'An error occured, please check your credentials';

      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_authenticateUser, _isLoading),
        );
  }
}
