import 'package:flutter/material.dart';
import 'package:movie/view%20model/LoginByFaceBookAndGoogle/SocialBloc.dart';
import 'package:movie/view/model/theme.dart';

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


  @override
  Widget build(BuildContext context) {

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
