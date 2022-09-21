import 'package:chat_app/widgets/pickers/user_image_picker.dart';

import '../../shared/validators.dart';
import 'package:flutter/material.dart';

enum AuthMode { signUp, logIn }

class AuthForm extends StatefulWidget {
  const AuthForm(this.authenicateUser, this.isLoading);

  final AuthenicateUser authenicateUser;
  final bool isLoading;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _userName = '';
  String _password = '';

  AuthMode authMode = AuthMode.logIn;

  void _changeAuthMode() {
    setState(() {
      switch (authMode) {
        case AuthMode.signUp:
          authMode = AuthMode.logIn;
          break;
        case AuthMode.logIn:
          authMode = AuthMode.signUp;
          break;
      }
    });
  }

  void _saveForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState.save();

    widget.authenicateUser(email: _email.trim(),
        userName: _userName.trim(),
        password: _password.trim(),
        authMode: authMode,
        ctx: context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (authMode == AuthMode.signUp)
                  UserImagePicker(),
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email address'),
                    validator: (value) {
                      String errorMessage;
                      if (Validators.email(value)) {
                        errorMessage = 'Please provide a valid email address';
                      }
                      return errorMessage;
                    },
                    onSaved: (value) {
                      _email = value;
                    },
                  ),
                  if (authMode == AuthMode.signUp)
                    TextFormField(
                      key: ValueKey('username'),
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (value) {
                        _userName = value;
                      },
                      validator: (value) {
                        String errorMessage;
                        int minLength = 4;
                        if (Validators.minLength(value, minLength)) {
                          errorMessage =
                          'Please provide  at least $minLength characters';
                        }
                        return errorMessage;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) {
                      _password = value;
                    },
                    validator: (value) {
                      String errorMessage;
                      int minLength = 7;
                      if (Validators.minLength(value, minLength)) {
                        errorMessage =
                        'Please provide write at least $minLength characters';
                      }
                      return errorMessage;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if(!widget.isLoading)
                    RaisedButton(child: Text(
                        (authMode == AuthMode.logIn) ? 'Login' : 'Sign Up'),
                        onPressed: _saveForm),
                  if(!widget.isLoading)
                    FlatButton(
                      onPressed: _changeAuthMode,
                      child: Text((authMode == AuthMode.logIn)
                          ? 'Create new account'
                          : 'Login instead'),
                      textColor: Theme
                          .of(context)
                          .primaryColor,
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

typedef AuthenicateUser = void Function({String email, String userName, String password, AuthMode authMode, BuildContext ctx});
