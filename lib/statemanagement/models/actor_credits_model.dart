// To parse this JSON data, do
//
//     final actorCredits = actorCreditsFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

ActorCredits actorCreditsFromJson(String str) =>
    ActorCredits.fromJson(json.decode(str));

String actorCreditsToJson(ActorCredits data) => json.encode(data.toJson());

class ActorCredits {
  List<Cast> cast;
  List<Crew> crew;
  int id;

  ActorCredits({
    required this.cast,
    required this.crew,
    required this.id,
  });

  factory ActorCredits.fromJson(Map<String, dynamic> json) => ActorCredits(
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
        "id": id,
      };
}

class Cast {
  bool adult;
  dynamic backdropPath;
  List<int> genreIds;
  int id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double voteAverage;
  int? voteCount;
  String? character;
  String? creditId;

  Cast({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.character,
    required this.creditId,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: (json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
        character: json["character"],
        creditId: json["credit_id"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "character": character,
        "credit_id": creditId,
      };
}

enum MediaType { MOVIE, TV }

final mediaTypeValues =
    EnumValues({"movie": MediaType.MOVIE, "tv": MediaType.TV});

class Crew {
  bool? adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double voteAverage;
  int? voteCount;
  String? creditId;
  Department? department;
  Job? job;

  String? originalName;
  String? firstAirDate;
  String? name;
  int? episodeCount;

  Crew({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.creditId,
    this.originalName,
    this.firstAirDate,
    this.name,
    this.episodeCount,
  });

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        creditId: json["credit_id"],
        originalName: json["original_name"],
        firstAirDate: json["first_air_date"],
        name: json["name"],
        episodeCount: json["episode_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "credit_id": creditId,
        "department": departmentValues.reverse[department],
        "original_name": originalName,
        "first_air_date": firstAirDate,
        "name": name,
        "episode_count": episodeCount,
      };
}

enum Department { DIRECTING, PRODUCTION, CREATOR }

final departmentValues = EnumValues({
  "Creator": Department.CREATOR,
  "Directing": Department.DIRECTING,
  "Production": Department.PRODUCTION
});

enum Job { DIRECTOR, PRODUCER, EXECUTIVE_PRODUCER, CREATOR }

final jobValues = EnumValues({
  "Creator": Job.CREATOR,
  "Director": Job.DIRECTOR,
  "Executive Producer": Job.EXECUTIVE_PRODUCER,
  "Producer": Job.PRODUCER
});

enum OriginCountry { GB, DE, IT, US, AU, CA }

final originCountryValues = EnumValues({
  "AU": OriginCountry.AU,
  "CA": OriginCountry.CA,
  "DE": OriginCountry.DE,
  "GB": OriginCountry.GB,
  "IT": OriginCountry.IT,
  "US": OriginCountry.US
});

enum OriginalLanguage { EN }

final originalLanguageValues = EnumValues({"en": OriginalLanguage.EN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
