import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MovieModel {
  final String? name;
  final String? sinopse;
  final String? type;
  final List<String>? comments;
  final String? imageMovie;
  final DateTime? availableDate;
  int? idLike;
  MovieModel({
    this.name,
    this.sinopse,
    this.type,
    this.comments,
    this.imageMovie,
    this.availableDate,
    required this.idLike,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'sinopse': sinopse,
      'type': type,
      'comments': comments,
      'imageMovie': imageMovie,
      'availableDate': availableDate?.toIso8601String(),
      'idLike': idLike,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      name: map['name'] != null ? map['name'] as String : null,
      sinopse: map['sinopse'] != null ? map['sinopse'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      comments: map['comments'] != null
          ? List<String>.from((map['comments'] as List<String>))
          : null,
      imageMovie: map['imageMovie'] != null
          ? map['imageMovie'] as String
          : null,
      availableDate: map['availableDate'] != null
          ? DateTime.parse(map['availableDate'])
          : null,
      idLike: map['idLike'] != null ? map['idLike'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);

  MovieModel copyWith({
    String? name,
    String? sinopse,
    String? type,
    List<String>? comments,
    String? imageMovie,
    DateTime? availableDate,
    int? idLike,
  }) {
    return MovieModel(
      name: name ?? this.name,
      sinopse: sinopse ?? this.sinopse,
      type: type ?? this.type,
      comments: comments ?? this.comments,
      imageMovie: imageMovie ?? this.imageMovie,
      availableDate: availableDate ?? this.availableDate,
      idLike: idLike ?? this.idLike,
    );
  }
}
