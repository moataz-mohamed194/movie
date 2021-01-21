import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/view/Screens/Home.dart';
import 'package:rxdart/rxdart.dart';
import 'package:toast/toast.dart';

import '../../view%20model/LoginByFaceBookAndGoogle/UI.dart';
import '../../view%20model/utils/SharedPreferences.dart';
import '../../view/Screens/Menu/Last.dart';

class ValidationBloc {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _repeatPasswordController = BehaviorSubject<String>();

  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Stream<String> get name => _nameController.stream.transform(validateName);
  Stream<String> get repeatPassword => _repeatPasswordController.stream
          .transform(validateRepeatPassword)
          .doOnData((event) {
        if (0 != _passwordController.value.compareTo(event)) {
          _repeatPasswordController.addError('password not same');
        }
      });

  Stream<bool> get loginValidation =>
      Rx.combineLatest2(email, password, (e, p) => true);
  Stream<bool> get signUpValidation => Rx.combineLatest4(
      name, email, password, repeatPassword, (e, p, t, y) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeRepeatPassword =>
      _repeatPasswordController.sink.add;
  dispose() {
    _emailController.close();
    _passwordController.close();
    _nameController.close();
    _repeatPasswordController.close();
  }

  String password2 = '';
  var validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    bool emailValid =
        RegExp(r"([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})")
            .hasMatch(email);

    if (emailValid == true) {
      sink.add(email);
    } else {
      sink.addError('Enter a valid email');
    }
  });
  var validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    bool nameValid = RegExp(r"([a-zA-Z])").hasMatch(name);

    if (nameValid == true) {
      sink.add(name);
    } else {
      sink.addError('Enter a full name');
    }
  });
  var validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    bool passwordValid0 = RegExp(r"[a-z]").hasMatch(password);
    bool passwordValid1 = RegExp(r"[A-Z]").hasMatch(password);
    bool passwordValid2 = RegExp(r"[0-9]").hasMatch(password);
    bool passwordValid3 = RegExp(r"[.!#$%&'*+-/=?^_`{|}~]").hasMatch(password);

    if (passwordValid0 == true &&
        passwordValid1 == true &&
        passwordValid2 == true &&
        passwordValid3 == true &&
        password.length > 8) {
      sink.add(password);
    } else {
      sink.addError('Enter valid password');
    }
  });
  var validateRepeatPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (repeatPassword, sink) {
    if (repeatPassword.length > 0) {
      sink.add(repeatPassword);
    } else {
      sink.addError('password not same');
    }
  });
  signUp(context) {
    FirebaseDatabase.instance.reference().child('users').push().set({
      'Email': "${_emailController.value}",
      "Name": "${_nameController.value}",
      'password': "${_passwordController.value}"
    }).whenComplete(() {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.value,
              password: _passwordController.value)
          .whenComplete(() {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) {
            return MultiBlocProvider(providers: [
              BlocProvider<UIBloc>(
                create: (context) => UIBloc(true),
              ),
            ], child: Home() //Home(),
                );
          }),
        );
        Toast.show("Login done", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

        print("Done");
      });
    });
    print(
        "signUp ${_nameController.value}:${_emailController.value}:${_passwordController.value}:${_repeatPasswordController.value}");
  }

  login(context) async {
    print("ddddddddddddddddddddddddddd");
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.value, password: _passwordController.value)
        .whenComplete(() {
      Constant.prefs.setBool('login', true);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) {
        return MultiBlocProvider(providers: [
          BlocProvider<UIBloc>(
            create: (context) => UIBloc(true),
          ),
        ], child: Home() //Home(),
            );
      }), (Route<dynamic> route) => false);
      Toast.show("Login done", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

      print(FirebaseAuth.instance.currentUser);
    });
  }
}
