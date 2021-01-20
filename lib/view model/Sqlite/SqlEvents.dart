class SqlEvents {}

class DeleteFromFavorite extends SqlEvents {
  final String movieId;

  DeleteFromFavorite(this.movieId);
}

class Start extends SqlEvents {
  final String movieId;

  Start(this.movieId);
}
class GetSavedMovies extends SqlEvents {

}
class GetSavedMoviesAfterDelete extends SqlEvents {
  final String movieId;

  GetSavedMoviesAfterDelete(this.movieId);
}

class AddToFavorite extends SqlEvents {
  final String movieId;
  final String moviePoster;
  final String movieCover;
  final String movieRate;
  final String movieDate;
  final String movieName;
  final String movieOverview;
  AddToFavorite(
    this.movieId,
    this.movieRate,
    this.movieCover,
    this.movieName,
    this.movieOverview,
    this.moviePoster,
    this.movieDate,
  );
}
