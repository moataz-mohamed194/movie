class Strings{

  static String mainKey = "67176b4f0d84b5b2151776584943dc04";
  static String mainUrl(String movie) {
    return "https://api.themoviedb.org/3/$movie?api_key=$mainKey";
  }
}