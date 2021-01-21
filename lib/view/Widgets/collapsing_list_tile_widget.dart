import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/view%20model/LoginByFaceBookAndGoogle/SocialBloc.dart';
import 'package:movie/view%20model/LoginByFaceBookAndGoogle/UI.dart';
import 'package:movie/view%20model/utils/SharedPreferences.dart';
import 'package:movie/view/model/theme.dart';
import 'package:toast/toast.dart';

import '../Screens/LoginAndSignUp/login.dart';

class CollapsingListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final AnimationController animationController;
  final bool isSelected;
  final Function onTap;

  CollapsingListTile(
      {@required this.title,
      @required this.icon,
      @required this.animationController,
      this.isSelected = false,
      this.onTap});

  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
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
                            // Navigator.pop(context);
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
                              // Navigator.pop(context);
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

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.3)
              : Colors.transparent,
        ),
        width: widthAnimation.value,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Wrap(
          children: <Widget>[
            Icon(
              widget.icon,
              color: widget.isSelected ? Colors.blue : Colors.white30,
              // size: 30.0,
            ),
            (widthAnimation.value <= 100) ? SizedBox(width: 20) : Container(),
            (widthAnimation.value <= 100)
                ? Text(widget.title,
                    style: widget.isSelected
                        ? listTitleSelectedTextStyle
                        : listTitleDefaultTextStyle)
                : Container()
          ],
        ),
      ),
    );
  }
}
