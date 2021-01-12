import 'package:flutter/material.dart';

// class ButtonWidget extends StatelessWidget {
//   final Color color;
//   final Color borderColor;
//   final Color textColor;
//   final double height;
//   final String text;
//   final Function onPressed;
//   const ButtonWidget(
//       {this.color,
//       this.text,
//       this.height,
//       this.borderColor,
//       this.textColor,
//       this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       onPressed: onPressed,
//       color: color,
//       shape: RoundedRectangleBorder(
//         side:
//             BorderSide(width: 3, color: borderColor, style: BorderStyle.solid),
//         borderRadius: BorderRadius.all(
//           Radius.circular(40),
//         ),
//       ),
//       minWidth: 80,
//       height: height,
//       child: Center(
//         child: Text(
//           "$text",
//           style: TextStyle(
//             fontSize: 15,
//             color: textColor,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

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
            color: color,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 3, color: color, style: BorderStyle.solid),
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
