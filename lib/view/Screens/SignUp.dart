import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/view%20model/Validation/ValidationProvidor.dart';
import 'package:movie/view/Widgets/buttonWidget.dart';
import 'package:movie/view/Widgets/textfield.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = ValidationProvider.of(context);

    // TODO: implement build
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Sign UP"),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  TextFileLogin(
                    hintText: "Name",
                    inputType: TextInputType.name,
                    textStream: bloc.name,
                    textChange: bloc.changeName,
                    textStyleColor: Colors.blue,
                  ),
                  TextFileLogin(
                    hintText: "Email",
                    textStream: bloc.email,
                    textChange: bloc.changeEmail,
                    inputType: TextInputType.emailAddress,
                    textStyleColor: Colors.blue,
                  ),
                  TextFileLogin(
                    hintText: "Password",
                    inputType: TextInputType.text,
                    textStream: bloc.password,
                    textChange: bloc.changePassword,
                    obscure: true,
                    textStyleColor: Colors.blue,
                  ),
                  TextFileLogin(
                    hintText: "repeat password",
                    textStream: bloc.repeatPassword,
                    textChange: bloc.changeRepeatPassword,

                    inputType: TextInputType.text,
                    textStyleColor: Colors.blue,
                    obscure: true,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: ButtonIconWidget(
                      onPressed: () {
                        bloc.signUp(context);
                      },
                      text: "Save",
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width / 3,
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
