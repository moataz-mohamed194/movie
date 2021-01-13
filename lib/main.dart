import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/model/Repository/LastRepository.dart';
import 'package:movie/view%20model/LastMovies/PostEvent.dart';
import 'package:movie/view%20model/LastMovies/PostStates.dart';
import 'package:movie/view%20model/TrendingMovies/TrendingStates.dart';
import 'package:movie/view%20model/utils/SharedPreferences.dart';
import 'package:movie/view/Screens/Home.dart';
import 'model/Repository/TrendingRepository.dart';
import 'view model/LastMovies/MovieBloc.dart';
import 'view model/LoginByFaceBookAndGoogle/UI.dart';
import 'view model/TrendingMovies/TrendingBloc.dart';
import 'view model/TrendingMovies/TrendingEvent.dart';
import 'view model/Validation/ValidationProvidor.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Constant.prefs = await SharedPreferences.getInstance();
  User data = FirebaseAuth.instance.currentUser;
  if (data != null) {
    runApp(MyApp(
      data: data,
      login: true,
    ));
  } else {
    runApp(MyApp(
      data: null,
      login: false,
    ));
  }
}

class MyApp extends StatelessWidget {
  final User data;
  final bool login;
  const MyApp({Key key, this.data, this.login}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValidationProvider(
      child: MaterialApp(
          title: 'Movie',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routes: <String, WidgetBuilder>{
            '/HomeScreen': (BuildContext context) => new Home(),
          },
          home: MultiBlocProvider(providers: [
            BlocProvider<UIBloc>(
              create: (context) => UIBloc(login),
            ),
            BlocProvider<MovieBloc>(
                create: (context) => MovieBloc(PostInitialState(), LastRepository())..add(DoFetchEvents("movie/popular"))
            ),
            BlocProvider<TrendingBloc>(
                create: (context) =>
                    TrendingBloc(TrendingInitialState(), TrendingRepository())..add(TrendingDoFetchEvents("trending/tv/day")),
                ),
          ], child: Home() //Home(),
              )),
    );
  }
}
