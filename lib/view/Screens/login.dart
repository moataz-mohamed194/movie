import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../view%20model/Validation/ValidationProvidor.dart';
import '../Widgets/buttonWidget.dart';
import '../Widgets/textfield.dart';
import 'SignUp.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final UIBloc cb = BlocProvider.of<UIBloc>(context);

    final bloc = ValidationProvider.of(context);
    // ValidationProvider bloc=new ValidationProvider();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TextFileLogin(
                textStream: bloc.email,
                textChange: bloc.changeEmail,
                hintText: "Email",
                inputType: TextInputType.emailAddress,
                textStyleColor: Colors.blue,
              ),
              TextFileLogin(
                textStream: bloc.password,
                textChange: bloc.changePassword,
                hintText: "Password",
                inputType: TextInputType.text,
                obscure: true,
                textStyleColor: Colors.blue,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: ButtonIconWidget(
                  onPressed: () {
                    bloc.login(context);
                  },
                  text: "Login",
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
