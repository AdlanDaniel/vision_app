// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PlanModel {
  int? id;
  String? name;
  String? description;
  double? price;
  DateTime? dueDate;
  List<String>? benefits;

  PlanModel({this.id, this.name, this.description, this.price, this.dueDate, this.benefits});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'dueDate': dueDate?.toIso8601String(),
    };
  }

  factory PlanModel.fromMap(Map<String, dynamic> map) {
    return PlanModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      price: map['price'] != null ? map['price'] as double : null,
      dueDate: map['dueDate'] != null
          ? DateTime.parse(map['dueDate'] as String)
          : null,
      benefits: map['benefits'] != null
          ? List<String>.from(map['benefits'] as List)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanModel.fromJson(String source) =>
      PlanModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
