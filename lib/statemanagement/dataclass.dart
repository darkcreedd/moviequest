import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moviequest/statemanagement/models/Series_Models/series_search_results.dart';
import 'package:moviequest/statemanagement/models/actor_credits_model.dart';
import 'package:moviequest/statemanagement/models/search_results_model.dart';
import 'package:http/http.dart' as http;
import 'package:moviequest/statemanagement/models/videos.dart';

import 'models/Series_Models/credits_results_model_series.dart';
import 'models/about_actor_model.dart';
import 'models/credits_results_model.dart';

class DataClass extends ChangeNotifier {
  //Receiving data from onboarding screen
  Future<SearchResults?>? discoveryResults;
  Future<SearchResults?>? topRatedResults;
  Future<SearchResults?>? popularResults;
  //Making an api call for searching movies
  int pageIndex = 0;
  int favoritesPageIndex = 0;
  int totalNumberOfSearchResults = 0;
  Future<SearchResults?>? mostSearchedResults;

  Future<SearchResults?> fetchResults(String query) async {
    try {
      String apiKey = '35ee30f0c9994499235d528ffd788019';
      String url =
          'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query';

      Uri uri = Uri.parse(url);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        String jsonString = response.body;
        debugPrint(searchResultsFromJson(jsonString).toString());

        return searchResultsFromJson(jsonString);
      }
    } on SocketException {
      debugPrint('No net');
      throw Exception('No Internet connection');
    }
    debugPrint('api get recieved!');
    notifyListeners();
    return null;
    // return responseJson;
  }

  Future<SearchResults?> fetchDiscoveries() async {
    try {
      String apiKey = '35ee30f0c9994499235d528ffd788019';
      String url =
          'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey';

      Uri uri = Uri.parse(url);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        String jsonString = response.body;
        debugPrint(searchResultsFromJson(jsonString).toString());

        return searchResultsFromJson(jsonString);
      }
    } on SocketException {
      debugPrint('No net');
      throw Exception('No Internet connection');
    }
    debugPrint('api get recieved!');
    notifyListeners();
    return null;
    // return responseJson;
  }

  Future<SearchResults?> fetchTopRated() async {
    try {
      String apiKey = '35ee30f0c9994499235d528ffd788019';
      String url =
          'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey';

      Uri uri = Uri.parse(url);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        String jsonString = response.body;
        debugPrint(searchResultsFromJson(jsonString).toString());

        return searchResultsFromJson(jsonString);
      }
    } on SocketException {
      debugPrint('No net');
      throw Exception('No Internet connection');
    }
    debugPrint('api get recieved!');
    notifyListeners();
    return null;
    // return responseJson;
  }

  Future<SearchResults?> fetchPopular() async {
    try {
      String apiKey = '35ee30f0c9994499235d528ffd788019';
      String url = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';

      Uri uri = Uri.parse(url);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        String jsonString = response.body;
        debugPrint(searchResultsFromJson(jsonString).toString());

        return searchResultsFromJson(jsonString);
      }
    } on SocketException {
      debugPrint('No net');
      throw Exception('No Internet connection');
    }
    debugPrint('api get recieved!');
    notifyListeners();
    return null;
    // return responseJson;
  }

  Future<CreditsResults?> fetchCredits(int movieId) async {
    try {
      String apiKey = '35ee30f0c9994499235d528ffd788019';
      String url =
          'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey';
      debugPrint(movieId.toString());

      Uri uri = Uri.parse(url);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        String jsonString = response.body;
        debugPrint(creditsResultsFromJson(jsonString).toString());

        return creditsResultsFromJson(jsonString);
      }
    } on SocketException {
      debugPrint('No net');
      throw Exception('No Internet connection');
    }
    debugPrint('api get recieved!');
    notifyListeners();
    return null;
    // return responseJson;
  }

  Future<ActorCredits?> fetchActorCredits(int actorId) async {
    try {
      String apiKey = '35ee30f0c9994499235d528ffd788019';
      // 16828
      String url =
          'https://api.themoviedb.org/3/person/$actorId/combined_credits?api_key=$apiKey&language=en-US';
      debugPrint(actorId.toString());

      Uri uri = Uri.parse(url);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        String jsonString = response.body;
        debugPrint(actorCreditsFromJson(jsonString).toString());

        return actorCreditsFromJson(jsonString);
      }
    } on SocketException {
      debugPrint('No net');
      throw Exception('No Internet connection');
    }
    debugPrint('api get recieved!');
    notifyListeners();
    return null;
    // return responseJson;
  }

  Future<AboutActor?> fetchActorDetails(int actorId) async {
    try {
      String apiKey = '35ee30f0c9994499235d528ffd788019';
      // 16828
      String url =
          'https://api.themoviedb.org/3/person/$actorId?api_key=$apiKey&language=en-US';
      debugPrint(actorId.toString());

      Uri uri = Uri.parse(url);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        String jsonString = response.body;
        debugPrint(aboutActorFromJson(jsonString).toString());

        return aboutActorFromJson(jsonString);
      }
    } on SocketException {
      debugPrint('No net');
      throw Exception('No Internet connection');
    }
    debugPrint('api get recieved!');
    notifyListeners();
    return null;
    // return responseJson;
  }

  Future<SearchResults?>? fetchSimilarMovies(int movieId) async {
    try {
      String apiKey = '35ee30f0c9994499235d528ffd788019';
      String url =
          'https://api.themoviedb.org/3/movie/$movieId/similar?api_key=$apiKey&language=en-US';
      debugPrint(movieId.toString());

      Uri uri = Uri.parse(url);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        String jsonString = response.body;
        debugPrint(searchResultsFromJson(jsonString).toString());

        return searchResultsFromJson(jsonString);
      }
    } on SocketException {
      debugPrint('No net');
      throw Exception('No Internet connection');
    }
    debugPrint('api get recieved!');
    notifyListeners();
    return null;
    // return responseJson;
  }
//Get Videos

  // Future<Videos?>? fetchVideos(int movieId) async {
  //   try {
  //     String apiKey = '35ee30f0c9994499235d528ffd788019';
  //     String url =
  //         'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey&language=en-US';
  //     debugPrint(movieId.toString());

  //     Uri uri = Uri.parse(url);

  //     final response = await http.get(uri);
  //     if (response.statusCode == 200) {
  //       String jsonString = response.body;
  //       debugPrint(videosFromJson(jsonString).toString());

  //       return videosFromJson(jsonString);
  //     }
  //   } on SocketException {
  //     debugPrint('No net');
  //     throw Exception('No Internet connection');
  //   }
  //   debugPrint('api get recieved!');
  //   notifyListeners();
  //   return null;
  //   // return responseJson;
  // }

//Genre sorting

  List<Map<String, dynamic>> genres = [
    {"id": 28, "name": "Action"},
    {"id": 12, "name": "Adventure"},
    {"id": 16, "name": "Animation"},
    {"id": 35, "name": "Comedy"},
    {"id": 80, "name": "Crime"},
    {"id": 99, "name": "Documentary"},
    {"id": 18, "name": "Drama"},
    {"id": 10751, "name": "Family"},
    {"id": 14, "name": "Fantasy"},
    {"id": 36, "name": "History"},
    {"id": 27, "name": "Horror"},
    {"id": 10402, "name": "Music"},
    {"id": 9648, "name": "Mystery"},
    {"id": 10749, "name": "Romance"},
    {"id": 878, "name": "Science Fiction"},
    {"id": 10770, "name": "TV Movie"},
    {"id": 53, "name": "Thriller"},
    {"id": 10752, "name": "War"},
    {"id": 37, "name": "Western"}
  ];

  String getGenreNamesByIds(List<int> ids) {
    List<String> names = [];
    for (var id in ids) {
      for (var genre in genres) {
        if (genre['id'] == id) {
          names.add(genre['name']);
        }
      }
    }
    return names.join(', ');
  }

  //TV SHOWS / SERIES

  int pageIndexM = 0;
  //Receiving data from onboarding screen
  Future<SeriesResult?>? discoveryTVResults;
  Future<SeriesResult?>? topRatedTVResults;
  Future<SeriesResult?>? popularTVResults;
  Future<SeriesResult?>? mostSearchedTVResults;

  //verified
  Future<SeriesResult?> fetchTVResults(String query) async {
    try {
      String apiKey = '35ee30f0c9994499235d528ffd788019';
      String url =
          'https://api.themoviedb.org/3/search/tv?api_key=$apiKey&query=$query';

      Uri uri = Uri.parse(url);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        String jsonString = response.body;
        debugPrint(seriesResultFromJson(jsonString).toString());

        return seriesResultFromJson(jsonString);
      }
    } on SocketException {
      debugPrint('No net');
      throw Exception('No Internet connection');
    }
    debugPrint('api get recieved!');
    notifyListeners();
    return null;
    // return responseJson;
  }

  //verified
  Future<SeriesResult?> fetchTVDiscoveries() async {
    try {
      String apiKey = '35ee30f0c9994499235d528ffd788019';
      String url = 'https://api.themoviedb.org/3/discover/tv?api_key=$apiKey';

      Uri uri = Uri.parse(url);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        String jsonString = response.body;
        debugPrint(seriesResultFromJson(jsonString).toString());

        return seriesResultFromJson(jsonString);
      }
    } on SocketException {
      debugPrint('No net');
      throw Exception('No Internet connection');
    }
    debugPrint('api get recieved!');
    notifyListeners();
    return null;
    // return responseJson;
  }

//verified
  Future<SeriesResult?> fetchTopRatedTV() async {
    try {
      String apiKey = '35ee30f0c9994499235d528ffd788019';
      String url = 'https://api.themoviedb.org/3/tv/top_rated?api_key=$apiKey';

      Uri uri = Uri.parse(url);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        String jsonString = response.body;
        debugPrint(seriesResultFromJson(jsonString).toString());

        return seriesResultFromJson(jsonString);
      }
    } on SocketException {
      debugPrint('No net');
      throw Exception('No Internet connection');
    }
    debugPrint('api get recieved!');
    notifyListeners();
    return null;
    // return responseJson;
  }

//verified
  Future<SeriesResult?> fetchPopularTV() async {
    try {
      String apiKey = '35ee30f0c9994499235d528ffd788019';
      String url = 'https://api.themoviedb.org/3/tv/popular?api_key=$apiKey';

      Uri uri = Uri.parse(url);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        String jsonString = response.body;
        debugPrint(seriesResultFromJson(jsonString).toString());

        return seriesResultFromJson(jsonString);
      }
    } on SocketException {
      debugPrint('No net');
      throw Exception('No Internet connection');
    }
    debugPrint('api get recieved!');
    notifyListeners();
    return null;
    // return responseJson;
  }

  Future<CreditResultS?>? fetchSeriesCredits(int seriesId) async {
    try {
      String apiKey = '35ee30f0c9994499235d528ffd788019';
      String url =
          'https://api.themoviedb.org/3/tv/$seriesId/credits?api_key=35ee30f0c9994499235d528ffd788019';
      debugPrint(seriesId.toString());

      Uri uri = Uri.parse(url);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        String jsonString = response.body;
        debugPrint(creditResultSFromJson(jsonString).toString());

        return creditResultSFromJson(jsonString);
      }
    } on SocketException {
      debugPrint('No net');
      return null;
      // throw Exception('No Internet connection');
    }
    debugPrint('api get recieved!');
    notifyListeners();
    return null;
    // return responseJson;
  }

  // Future<ActorCredits?> fetchActorCredits(int actorId) async {
  //   try {
  //     String apiKey = '35ee30f0c9994499235d528ffd788019';
  //     // 16828
  //     String url =
  //         'https://api.themoviedb.org/3/person/$actorId/combined_credits?api_key=$apiKey&language=en-US';
  //     debugPrint(actorId.toString());

  //     Uri uri = Uri.parse(url);

  //     final response = await http.get(uri);
  //     if (response.statusCode == 200) {
  //       String jsonString = response.body;
  //       debugPrint(actorCreditsFromJson(jsonString).toString());

  //       return actorCreditsFromJson(jsonString);
  //     }
  //   } on SocketException {
  //     debugPrint('No net');
  //     throw Exception('No Internet connection');
  //   }
  //   debugPrint('api get recieved!');
  //   notifyListeners();
  //   return null;
  //   // return responseJson;
  // }

  // Future<AboutActor?> fetchActorDetails(int actorId) async {
  //   try {
  //     String apiKey = '35ee30f0c9994499235d528ffd788019';
  //     // 16828
  //     String url =
  //         'https://api.themoviedb.org/3/person/$actorId?api_key=$apiKey&language=en-US';
  //     debugPrint(actorId.toString());

  //     Uri uri = Uri.parse(url);

  //     final response = await http.get(uri);
  //     if (response.statusCode == 200) {
  //       String jsonString = response.body;
  //       debugPrint(aboutActorFromJson(jsonString).toString());

  //       return aboutActorFromJson(jsonString);
  //     }
  //   } on SocketException {
  //     debugPrint('No net');
  //     throw Exception('No Internet connection');
  //   }
  //   debugPrint('api get recieved!');
  //   notifyListeners();
  //   return null;
  //   // return responseJson;
  // }
//verfied
  Future<SeriesResult?>? fetchSimilarTVShows(int seriesId) async {
    try {
      String apiKey = '35ee30f0c9994499235d528ffd788019';
      String url =
          'https://api.themoviedb.org/3/tv/$seriesId/similar?api_key=$apiKey&language=en-US';
      debugPrint(seriesId.toString());

      Uri uri = Uri.parse(url);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        String jsonString = response.body;
        debugPrint(seriesResultFromJson(jsonString).toString());

        return seriesResultFromJson(jsonString);
      }
    } on SocketException {
      debugPrint('No net');
      throw Exception('No Internet connection');
    }
    debugPrint('api get recieved!');
    notifyListeners();
    return null;
    // return responseJson;
  }
//Get Videos

  Future<Videos?>? fetchTVVideos(int seriesId) async {
    try {
      String apiKey = '35ee30f0c9994499235d528ffd788019';
      String url =
          'https://api.themoviedb.org/3/movie/$seriesId/videos?api_key=$apiKey&language=en-US';
      debugPrint(seriesId.toString());

      Uri uri = Uri.parse(url);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        String jsonString = response.body;
        debugPrint(videosFromJson(jsonString).toString());

        return videosFromJson(jsonString);
      }
    } on SocketException {
      debugPrint('No net');
      throw Exception('No Internet connection');
    }
    debugPrint('api get recieved!');
    notifyListeners();
    return null;
    // return responseJson;
  }
}
