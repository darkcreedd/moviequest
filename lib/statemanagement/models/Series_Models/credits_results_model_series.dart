// To parse this JSON data, do
//
//     final creditResultS = creditResultSFromJson(jsonString);

import 'dart:convert';

CreditResultS creditResultSFromJson(String str) =>
    CreditResultS.fromJson(json.decode(str));

String creditResultSToJson(CreditResultS data) => json.encode(data.toJson());

class CreditResultS {
  List<Casts> cast;
  List<dynamic> crew;
  int id;

  CreditResultS({
    required this.cast,
    required this.crew,
    required this.id,
  });

  factory CreditResultS.fromJson(Map<String, dynamic> json) => CreditResultS(
        cast: List<Casts>.from(json["cast"].map((x) => Casts.fromJson(x))),
        crew: List<dynamic>.from(json["crew"].map((x) => x)),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x)),
        "id": id,
      };
}

class Casts {
  bool adult;
  int gender;
  int id;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  String character;
  String creditId;
  int order;

  Casts({
    required this.adult,
    required this.gender,
    required this.id,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory Casts.fromJson(Map<String, dynamic> json) => Casts(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "character": character,
        "credit_id": creditId,
        "order": order,
      };
}

enum KnownForDepartment { ACTING }

final knownForDepartmentValues =
    EnumValues({"Acting": KnownForDepartment.ACTING});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
