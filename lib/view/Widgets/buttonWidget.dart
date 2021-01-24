import 'package:flutter/material.dart';
import 'package:movie/view/model/theme.dart';

class ButtonIconWidget extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final Color textColor;
  final double height;
  final Stream textStream;
  final String text;
  final Function onPressed;
  const ButtonIconWidget(
      {this.color,
      this.text,
      this.height,
      this.textStream,
      this.borderColor,
      this.textColor,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  RaisedButton(
            onPressed:onPressed,
            color: drawerBackgroundColor,

        shape: RoundedRectangleBorder(
              side: BorderSide(width: 3, color: drawerBackgroundColor, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Text(
              '$text',
              style: TextStyle(
                  fontSize: 15, color: textColor, fontWeight: FontWeight.bold),
            )
        );
  }
}
