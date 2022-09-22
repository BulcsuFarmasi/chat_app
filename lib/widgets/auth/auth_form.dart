import 'dart:io';

import 'package:chat_app/widgets/pickers/user_image_picker.dart';

import '../../shared/validators.dart';
import 'package:flutter/material.dart';

enum AuthMode { signUp, logIn }

class AuthForm extends StatefulWidget {
  const AuthForm(this.authenicateUser, this.isLoading, {super.key});

  final AuthenicateUser authenicateUser;
  final bool isLoading;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _userName = '';
  String _password = '';
  File? _userImageFile;

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

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _saveForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_userImageFile == null && authMode == AuthMode.signUp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please pick an image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();

    widget.authenicateUser(
        email: _email.trim(),
        userName: _userName.trim(),
        password: _password.trim(),
        image: _userImageFile,
        authMode: authMode);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (authMode == AuthMode.signUp)
                    UserImagePicker(_pickedImage),
                  TextFormField(
                    key: const ValueKey('email'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(labelText: 'Email address'),
                    validator: (String? value) {
                      String? errorMessage;
                      if (Validators.email(value)) {
                        errorMessage = 'Please provide a valid email address';
                      }
                      return errorMessage;
                    },
                    onSaved: (String? value) {
                      _email = value!;
                    },
                  ),
                  if (authMode == AuthMode.signUp)
                    TextFormField(
                      key: const ValueKey('username'),
                      decoration: const InputDecoration(labelText: 'Username'),
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      onSaved: (String? value) {
                        _userName = value!;
                      },
                      validator: (String? value) {
                        String? errorMessage;
                        int minLength = 4;
                        if (Validators.minLength(value, minLength)) {
                          errorMessage =
                              'Please provide  at least $minLength characters';
                        }
                        return errorMessage;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (String? value) {
                      _password = value!;
                    },
                    validator: (String? value) {
                      String? errorMessage;
                      int minLength = 7;
                      if (Validators.minLength(value, minLength)) {
                        errorMessage =
                            'Please provide write at least $minLength characters';
                      }
                      return errorMessage;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                        onPressed: _saveForm,
                        child: Text((authMode == AuthMode.logIn)
                            ? 'Login'
                            : 'Sign Up')),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: _changeAuthMode,
                      style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).primaryColor),
                      child: Text((authMode == AuthMode.logIn)
                          ? 'Create new account'
                          : 'Login instead'),
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

typedef AuthenicateUser = void Function(
    {required String email,
    String? userName,
    required String password,
    File? image,
    required AuthMode authMode});
