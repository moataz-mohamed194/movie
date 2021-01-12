import 'package:flutter/material.dart';

class TextFileLogin extends StatelessWidget {
  final Stream textStream;
  final Function textChange;
  final String hintText;
  final TextInputType inputType;
  final Icon textIcon;
  final String errorText;
  final Color textStyleColor;
  final bool obscure;
  final String oldData;
  final TextStyle hintStyle;
  const TextFileLogin(
      {this.textStream,
      this.textChange,
      this.hintStyle,
      this.textStyleColor,
      this.hintText,
      this.errorText,
      this.inputType,
      this.textIcon,
      this.obscure = false,
      this.oldData});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width / 1.25,
      child: StreamBuilder<String>(
          stream: textStream,
          builder: (context, snapshot) {
            return TextFormField(
                style: TextStyle(color: textStyleColor),
                autofocus: false,
                keyboardType: inputType,
                obscureText: obscure,
                onChanged: textChange,
                decoration: InputDecoration(
                  prefixIcon: textIcon,
                  hintText: "   $hintText",
                  helperStyle: TextStyle(
                    color: textStyleColor,
                    fontWeight: FontWeight.bold,
                  ),
                  hintStyle: hintStyle,
                  errorText: snapshot.error,
                ),
                initialValue: oldData);
          }),
    );
  }
}
