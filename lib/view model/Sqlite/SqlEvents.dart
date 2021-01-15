import 'package:equatable/equatable.dart';

class SqlEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class IconEvents extends SqlEvents{
  final String movieId;
  final String moviePoster;
  final String movieCover;
  final String movieRate;
  final String movieDate;
  final String movieName;
  final String movieOverview;
  IconEvents(this.movieId,this.movieRate,this.movieCover,this.movieName,this.movieOverview,this.moviePoster,this.movieDate);
  @override
  List<Object> get props => [movieId,moviePoster,movieCover,movieRate,movieDate,movieName,movieOverview];
}
class dataEvents extends SqlEvents{
  @override
  List<Object> get props => [];
}
// class IconEven extends SqlEvents{}