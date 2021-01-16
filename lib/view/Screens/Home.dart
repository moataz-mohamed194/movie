import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

import '../../view%20model/LoginByFaceBookAndGoogle/SocialBloc.dart';
import '../../view%20model/LoginByFaceBookAndGoogle/UI.dart';
import '../../view%20model/Movies/MovieBloc.dart';
import '../../view%20model/Movies/MovieStates.dart';
import '../../view%20model/utils/SharedPreferences.dart';
import '../Widgets/Moviecard.dart';
import 'DetailsMovie.dart';
import 'SavedMovies.dart';
import 'TrendingMovie.dart';
import 'login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SocialBloc social = SocialBloc();

  UIBloc cb;
  @override
  Widget build(BuildContext context) {
    cb = BlocProvider.of<UIBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Latest updates"),
      ),
      drawer: Drawer(
        elevation: 80.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: BlocBuilder<UIBloc, bool>(builder: (context, state) {
                if (state == false) {
                  return InkWell(
                    child: Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(200)),
                            child: Image.asset(
                              'assets/empty.png',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Login")
                      ],
                    ),
                    onTap: () {
                      openLoginAlert(context);
                    },
                  );
                } else {
                  return StreamBuilder<User>(
                      initialData: FirebaseAuth.instance.currentUser,
                      builder: (context, state0) {
                        print("state0");
                        print(state0);
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
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(state0.data.email)
                                  ],
                                ),
                              ),
                              Positioned(
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
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(child: Text("....."));
                        }
                      });
                }
              }),
            ),
            ListTile(
              title: Text('Liked'),
              leading: Icon(Icons.favorite),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SavedMovie()));
              },
            ),
            Divider(
              color: Colors.black,
              endIndent: MediaQuery.of(context).size.width / 7,
              indent: MediaQuery.of(context).size.width / 7,
            ),
            ListTile(
              title: Text('Trending'),
              leading: Icon(Icons.trending_up),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TrendingMovie()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        alignment: Alignment.center,
        child: BlocBuilder<MovieBloc, MovieStates>(builder: (context, state) {
          if (state is PostInitialState) {
            return Center(child: Center(child: CircularProgressIndicator()));
          } else if (state is LoadingState) {
            return Center(child: Center(child: CircularProgressIndicator()));
          } else if (state is FetchSuccess) {
            return Wrap(
              children: state.posts
                  .map((item) => Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: MovieCard(
                          movieImg:
                              "http://image.tmdb.org/t/p/w500${item.posterPath}",
                          // liked: false,
                          movieName: item.originalTitle,
                          movieRate: "${item.voteAverage}",
                          releaseDate: "${item.id}",
                          onClick: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsMovie(
                                          nameMovie: item.originalTitle,
                                          date: item.releaseDate,
                                          description: item.overview,
                                          imageCover: item.backdropPath,
                                          imagePoster: item.posterPath,
                                          rate: item.voteAverage,
                                        )));
                          },
                          movieId: item.id,
                          movieImgCover: item.backdropPath,
                          movieOverview: item.overview,
                        ),
                      ))
                  .toList()
                  .cast<Widget>(),
            );
          } else if (state is ErrorState) {
            print(state.message.toString());
            return Center(child: Text("${state.message.toString()}"));
          } else {
            return Center(child: Text("Error"));
          }
        }),
      )),
    );
  }

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
                            Navigator.pop(context);
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
                              Navigator.pop(context);
                              Navigator.pop(context);
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
  void dispose() {
    cb.close();
    super.dispose();
  }
}
