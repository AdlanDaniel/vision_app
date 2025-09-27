// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:image_picker/image_picker.dart';

class OnBoardingUserModel {
   String name;
   XFile? photoUser;
  OnBoardingUserModel({
    required this.name,
    this.photoUser,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  

}
