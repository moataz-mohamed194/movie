class SqlEvents {}

class DeleteFromFavorite extends SqlEvents {
  final String movieId;

  DeleteFromFavorite(this.movieId);
}

class AddToFavorit extends SqlEvents {
  final String movieId;
  final String moviePoster;
  final String movieCover;
  final String movieRate;
  final String movieDate;
  final String movieName;
  final String movieOverview;
  AddToFavorit(
    this.movieId,
    this.movieRate,
    this.movieCover,
    this.movieName,
    this.movieOverview,
    this.moviePoster,
    this.movieDate,
  );
}
