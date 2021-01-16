import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../view%20model/utils/SharedPreferences.dart';

class SocialBloc {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<bool> signInFacebook() async {
    FacebookLogin facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,picture&access_token=$token');
        print(graphResponse.body);
        if (result.status == FacebookLoginStatus.loggedIn) {
          final credential = FacebookAuthProvider.credential(token);
          _auth.signInWithCredential(credential);
          Constant.prefs.setBool('login', true);
          return true;
        }

        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        return false;
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        return false;
        break;
    }
    return false;
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  Future<bool> handleSignIn() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      print(googleUser);
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      await _auth.signInWithCredential(credential).whenComplete(() {
        Constant.prefs.setBool('login', true);
      });
      return true;
    } catch (error) {
      print("error:$error");
      return false;
    }
  }
}
