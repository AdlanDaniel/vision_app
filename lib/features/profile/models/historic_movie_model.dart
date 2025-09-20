// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class HistoricMovieModel {
  String? id;
  String? name;
  String? imageUrl;
  String? year;

  HistoricMovieModel({this.id, this.name, this.imageUrl, this.year});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'year': year,
    };
  }

  factory HistoricMovieModel.fromMap(Map<String, dynamic> map) {
    return HistoricMovieModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      year: map['year'] != null ? map['year'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoricMovieModel.fromJson(String source) => HistoricMovieModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
