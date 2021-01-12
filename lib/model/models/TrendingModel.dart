class TrendingModel {
  int page;
  List<Results> results;
  int totalPages;
  int totalResults;

  TrendingModel({this.page, this.results, this.totalPages, this.totalResults});

  TrendingModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}

class Results {
  String overview;
  int voteCount;
  String backdropPath;
  int id;
  List<int> genreIds;
  List<String> originCountry;
  String originalLanguage;
  double voteAverage;
  String posterPath;
  String firstAirDate;
  String originalName;
  String name;
  double popularity;
  String mediaType;

  Results(
      {this.overview,
        this.voteCount,
        this.backdropPath,
        this.id,
        this.genreIds,
        this.originCountry,
        this.originalLanguage,
        this.voteAverage,
        this.posterPath,
        this.firstAirDate,
        this.originalName,
        this.name,
        this.popularity,
        this.mediaType});

  Results.fromJson(Map<String, dynamic> json) {
    overview = json['overview'];
    voteCount = json['vote_count'];
    backdropPath = json['backdrop_path'];
    id = json['id'];
    genreIds = json['genre_ids'].cast<int>();
    originCountry = json['origin_country'].cast<String>();
    originalLanguage = json['original_language'];
    voteAverage = json['vote_average'];
    posterPath = json['poster_path'];
    firstAirDate = json['first_air_date'];
    originalName = json['original_name'];
    name = json['name'];
    popularity = json['popularity'];
    mediaType = json['media_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['overview'] = this.overview;
    data['vote_count'] = this.voteCount;
    data['backdrop_path'] = this.backdropPath;
    data['id'] = this.id;
    data['genre_ids'] = this.genreIds;
    data['origin_country'] = this.originCountry;
    data['original_language'] = this.originalLanguage;
    data['vote_average'] = this.voteAverage;
    data['poster_path'] = this.posterPath;
    data['first_air_date'] = this.firstAirDate;
    data['original_name'] = this.originalName;
    data['name'] = this.name;
    data['popularity'] = this.popularity;
    data['media_type'] = this.mediaType;
    return data;
  }
}
