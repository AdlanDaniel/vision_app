import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? profilePhoto;

  UserModel({
     this.id,
     this.name,
     this.email,
     this.profilePhoto,
  });

  

  Map<String, dynamic> toMap() {
     Map<String,dynamic> map = {
      'id': id,
      'name': name,
      'email': email,
      'profilePhoto': profilePhoto,
    };
    map.removeWhere((key,value) => value == null);
    return map;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      profilePhoto: map['profilePhoto'] != null ? map['profilePhoto'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
