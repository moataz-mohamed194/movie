import 'package:flutter/material.dart';
import 'package:movie/view/Screens/Menu/Last.dart';
import 'package:movie/view/Screens/Menu/SavedMovies.dart';
import 'package:movie/view/Screens/Menu/TrendingMovie.dart';


class NavigationModel {
  String title;
  IconData icon;

  NavigationModel({this.title, this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: "Home", icon: Icons.home),
  NavigationModel(title: "Liked", icon: Icons.favorite),
  NavigationModel(title: "Trending", icon: Icons.trending_up),
];
List<Widget> data = [Last(), SavedMovie(), TrendingMovie()];
List<Widget> titles = [
  Text(
    "Home ",
  ),
  Text(
    "Liked ",
  ),
  Text(
    "Trending ",
  ),
];
