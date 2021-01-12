import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsMovie extends StatelessWidget {
  final String nameMovie;

  const DetailsMovie({Key key, this.nameMovie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                        "http://image.tmdb.org/t/p/w500/srYya1ZlI97Au4jUYAktDe3avyA.jpg",height: 220,width: MediaQuery.of(context).size.width,),
                    Align(
                      heightFactor: 7,
                      alignment: Alignment.bottomCenter,
                      child: Wrap(
                        children: [
                          Text(
                            nameMovie,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppBar(
                      iconTheme: IconThemeData(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 290,
                    child: Card(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Image.network(
                                    "http://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg")),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Wrap(
                                    children: [
                                      Text(
                                        "Movie name",
                                        style: TextStyle(fontSize: 24),
                                      )
                                    ],
                                  ),
                                  Text("20-11-2020",
                                      style: TextStyle(fontSize: 22)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.grey,
                                      ),
                                      Text("6.9",
                                          style: TextStyle(fontSize: 20)),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Overview",
                          style: TextStyle(fontSize: 32, color: Colors.red)),
                      SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        children: [
                          Text(
                              "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s and finds a formidable foe by the name of the Cheetah.",
                              style: TextStyle(fontSize: 15))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
