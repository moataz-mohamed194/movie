import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/model/Repository/MovieRepository.dart';
import 'package:movie/model/Repository/SQLDatabase.dart';
import 'package:movie/view%20model/LoginByFaceBookAndGoogle/UI.dart';
import 'package:movie/view%20model/Movies/MovieBloc.dart';
import 'package:movie/view%20model/Movies/MovieEvents.dart';
import 'package:movie/view%20model/Sqlite/SqlBloc.dart';
import 'package:movie/view%20model/utils/SharedPreferences.dart';
import 'package:movie/view/model/theme.dart';
import 'package:toast/toast.dart';

import '../../../view%20model/Validation/ValidationProvidor.dart';
import '../../Widgets/buttonWidget.dart';
import '../../Widgets/textfield.dart';
import '../Home.dart';
import 'SignUp.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc0 = ValidationProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: drawerBackgroundColor,

      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TextFileLogin(
                textStream: bloc0.email,
                textChange: bloc0.changeEmail,
                hintText: "Email",
                inputType: TextInputType.emailAddress,
                textStyleColor: Colors.blue,
              ),
              TextFileLogin(
                textStream: bloc0.password,
                textChange: bloc0.changePassword,
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
                  onPressed: () async {
                    if (await bloc0.login()) {

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) {
                        return MultiBlocProvider(providers: [
                          BlocProvider<UIBloc>(
                            create: (context) =>
                                UIBloc(Constant.prefs.getBool('login')),
                          ),
                          BlocProvider<MovieBloc>(
                              create: (context) => MovieBloc(MovieRepository())
                                ..add(DoFetchEvents("movie/popular"))),
                          BlocProvider<SqlBloc>(
                              create: (context) => SqlBloc(SQLDatabase())),
                        ], child: Home());
                      }), (Route<dynamic> route) => false);
                      Toast.show("Login done", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    } else {
                      Toast.show("Falied", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    }
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
                  style: TextStyle(color: drawerBackgroundColor),
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
    );
  }
}
