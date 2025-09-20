import 'package:firebase_storage/firebase_storage.dart';
import 'package:vision_app/core/rest_client/rest_client.dart';
import 'package:vision_app/features/auth/repository/model/user_model.dart';

abstract class ProfileDatasource {
  Future<Map<String, dynamic>> fetchUserProfileData();

  Future<void> updateUserProfileData(UserModel user);

  Future<void> deleteUserProfileData(int userId);

  Future<void> registerUserPhoto(String uid, String photoUrl);
}

class ProfileDatasourceImpl implements ProfileDatasource {
  ProfileDatasourceImpl(this.restClient);
  RestClient restClient;

  @override
  Future<Map<String, dynamic>> fetchUserProfileData() async {
    // try {
    //   final RestClientResponse response = await restClient.get(
    //     '/api/users/me',
    //   );
    //   if (response.statusCode != 200) {
    //     log(
    //       'Status code: ${response.statusCode} / Messagem: ${response.statusMessage}',
    //     );
    //     throw Exception(response.statusMessage);
    //   }

    //   return response.data;
    // } catch (e) {
    //   log(e.toString());
    //   throw Exception('Erro datasource');
    // }

    await Future.delayed(Duration(seconds: 1));

    return {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      // 'profilePhoto': 'https://pxhere.com/pt/photo/451653',
      'profilePhoto': null,
    };
  }

  @override
  Future<void> updateUserProfileData(UserModel model) async {
    // try {
    //     final RestClientResponse response = await restClient.patch(
    //       '/api/users/updateMe',data: model.toMap()
    //     );
    //     if (response.statusCode != 200) {
    //       log(
    //         'Status code: ${response.statusCode} / Messagem: ${response.statusMessage}',
    //       );
    //       throw Exception(response.statusMessage);
    //     }

    //   } catch (e) {
    //     log(e.toString());
    //     throw Exception('Erro datasource');
    //   }
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Future<void> deleteUserProfileData(int userId) async {
    //   try {
    //   final RestClientResponse response = await restClient.delete(
    //     '/api/users/$userId',
    //   );
    //   if (response.statusCode != 200) {
    //     log(
    //       'Status code: ${response.statusCode} / Messagem: ${response.statusMessage}',
    //     );
    //     throw Exception(response.statusMessage);
    //   }

    // } catch (e) {
    //   log(e.toString());
    //   throw Exception('Erro datasource');
    // }

    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Future<void> registerUserPhoto(String uid, String photoUrl) async {
    await Future.delayed(Duration(seconds: 1));
  }
}

class ProfileFirebaseDatasourceImpl implements ProfileDatasource {
  ProfileFirebaseDatasourceImpl(this._firebaseStorage);
  final FirebaseStorage _firebaseStorage;

  @override
  Future<void> registerUserPhoto(String uid, String photoUrl) async {
    // try {
    //   final Reference ref = _firebaseStorage.ref().child('users/$uid.jpg');
    //   await ref.putFile(Uri.parse(photoUrl).toFilePath());
    // } catch (e) {
    //   throw Exception('Erro ao enviar foto');
    // }
  }

  @override
  Future<void> updateUserProfileData(UserModel model) async {
    // try {
    //   final Reference ref = _firebaseStorage.ref().child('users/${model.id}.jpg');
    //   await ref.putFile(Uri.parse(model.profilePhoto).toFilePath());
    // } catch (e) {
    //   throw Exception('Erro ao atualizar foto');
    // }
  }
  
  @override
  Future<void> deleteUserProfileData(int userId) {
    // TODO: implement deleteUserProfileData
    throw UnimplementedError();
  }
  
  @override
  Future<Map<String, dynamic>> fetchUserProfileData() {
    // TODO: implement fetchUserProfileData
    throw UnimplementedError();
  }

  
}
