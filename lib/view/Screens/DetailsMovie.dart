import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsMovie extends StatelessWidget {
  final String nameMovie;
  final String imageCover;
  final String imagePoster;
  final String rate;
  final String date;
  final String description;

  const DetailsMovie(
      {Key key,
      this.nameMovie,
      this.imageCover,
      this.imagePoster,
      this.description,
      this.rate,
      this.date})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      "http://image.tmdb.org/t/p/w500$imageCover",
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                    ),
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
                                    "http://image.tmdb.org/t/p/w500$imagePoster")),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Wrap(
                                    children: [
                                      Text(
                                        nameMovie,
                                        style: TextStyle(fontSize: 24),
                                      )
                                    ],
                                  ),
                                  Text(date, style: TextStyle(fontSize: 22)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.grey,
                                      ),
                                      Text("$rate",
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
                          Text(description,
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
