
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/view%20model/LoginByFaceBookAndGoogle/SocialBloc.dart';
import 'package:movie/view%20model/LoginByFaceBookAndGoogle/UI.dart';
import 'package:movie/view%20model/utils/SharedPreferences.dart';
import 'package:movie/view/Screens/LoginAndSignUp/login.dart';
import 'package:toast/toast.dart';

class LogInListTile extends StatefulWidget {
  final AnimationController animationController;
  final bool isSelected;

  LogInListTile(
      { @required this.animationController,
        this.isSelected = false,
      });

  @override
  _CollapsingListTileState0 createState() => _CollapsingListTileState0();
}

class _CollapsingListTileState0 extends State<LogInListTile> {
  Animation<double> widthAnimation, sizedBoxAnimation;
  final SocialBloc social = SocialBloc();

  @override
  void initState() {
    super.initState();
    widthAnimation =
        Tween<double>(begin: 200, end: 70).animate(widget.animationController);
    sizedBoxAnimation =
        Tween<double>(begin: 10, end: 0).animate(widget.animationController);
  }

  UIBloc cb;
  Future<void> openLoginAlert(context) async {
    cb = BlocProvider.of<UIBloc>(context);
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Ways to login"),
            content: SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                        onPressed: () async {
                          if (await social.handleSignIn() == true) {
                            cb.add(CounterEvent.add);
                            Toast.show("Login done", context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                            Navigator.pop(context);
                            // Navigator.pop(context);
                          }
                        },
                        child: Container(
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.all(Radius.circular(200)),
                            child: Image.asset(
                              'assets/google.png',
                            ),
                          ),
                        )),
                  ),
                  Expanded(
                      child: FlatButton(
                          onPressed: () async {
                            if (await social.signInFacebook() == true) {
                              cb.add(CounterEvent.add);
print("0000${await FirebaseAuth.instance.currentUser}");
                              Navigator.pop(context);
                              // Navigator.pop(context);
                              Toast.show("Login done", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                            }
                          },
                          child: Container(
                            child: ClipRRect(
                              borderRadius:
                              BorderRadius.all(Radius.circular(200)),
                              child: Image.asset(
                                'assets/facebook.png',
                              ),
                            ),
                          ))),
                  Expanded(
                    child: FlatButton(
                        onPressed: () {
                          // FirebaseAuth.instance.signOut();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Container(
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.all(Radius.circular(200)),
                            child: Image.asset(
                              'assets/plus.png',
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    cb = BlocProvider.of<UIBloc>(context);

    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      // padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Wrap(
        // crossAxisAlignment: CrossAxisAlignment.,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          BlocBuilder<UIBloc, bool>(builder: (context, state) {
            if (state == false) {
              return Center(
                child: InkWell(
                  child: Column(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(200)),
                          child: Image.asset(
                            'assets/empty.png',
                          ),
                        ),
                      ),
                      (widthAnimation.value <= 100)
                          ? SizedBox(
                        height: 15,
                      )
                          : Container(),
                      (widthAnimation.value <= 100)
                          ? Text("Login")
                          : Container()
                    ],
                  ),
                  onTap: () {
                    openLoginAlert(context);
                  },
                ),
              );
            } else {
              return StreamBuilder<User>(
                  initialData: FirebaseAuth.instance.currentUser,
                  builder: (context, state0) {
                    print("state0");
                    print("\$$state0");
                    print("state0");
                    if (state0.hasData) {
                      return Stack(
                        children: [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(200)),
                                    child: state0.data.photoURL != null
                                        ? Image.network(
                                      "${state0.data.photoURL}",
                                    )
                                        : Image.asset(
                                      'assets/empty.png',
                                    ),
                                  ),
                                ),
                                (widthAnimation.value <= 100)
                                    ? SizedBox(
                                  height: 15,
                                )
                                    : Container(),
                                (widthAnimation.value <= 100)
                                    ? Text(
                                  state0.data.email,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                                    : Container()
                              ],
                            ),
                          ),
                          (widthAnimation.value <= 100)
                              ? Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Constant.prefs.setBool('login', false);
                                cb.add(CounterEvent.remove);
                              },
                              icon: Icon(
                                FontAwesomeIcons.signOutAlt,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                              : Container(),
                        ],
                      );
                    } else {
                      return Center(child: Text(".....${state0.hasError}:${state0.error}",style: TextStyle(color: Colors.white),));
                    }
                  });
            }
          }),
        ],
      ),
    );
  }
}
