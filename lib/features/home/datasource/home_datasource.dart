import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vision_app/core/rest_client/rest_client.dart';

abstract class HomeDataSource {
  Future<Map<String, dynamic>> fetchMovie();
  Future<Map<String, dynamic>> fetchQuantityLikes();
  Future<void> likeMovie({required int userId, required int movieId});
  Future<void> unlikeMovie({required int idLike});
}

class HomeDataSourceImpl implements HomeDataSource {
  RestClient restClient;
  HomeDataSourceImpl({required this.restClient});
  @override
  Future<Map<String, dynamic>> fetchMovie() async {
    // try {
    //   final RestClientResponse response = await restClient.get(
    //     '/movies?populate=poster',
    //   );
    //   if (response.statusCode != 200) {
    //     log.log(
    //       'Status code: ${response.statusCode} / Messagem: ${response.statusMessage}',
    //     );
    //     throw Exception(response.statusMessage);
    //   }

    //   return response.data;
    // } catch (e) {
    //   log.log(e.toString());
    //   throw Exception('Erro datasource');
    // }
    await Future.delayed(const Duration(seconds: 1));
    // throw Exception('Erro ao buscar filme');
    return {
      'name': 'Inception',
      'sinopse':
          'Dom Cobb (Leonardo DiCaprio) is a thief with the rare ability to enter people\'s dreams and steal their secrets from their subconscious. His skill has made him a hot commodity in the world of corporate espionage but has also cost him everything he loves. Cobb gets a chance at redemption when he is offered a seemingly impossible task: Plant an idea in someone\'s mind. If he succeeds, it will be the perfect crime, but a dangerous enemy anticipates Cobb\'s every move.',
      'type': 'Fiction',
      'comments': [
        'Watching Inception was nothing short of an extraordinary journey that left me in awe long after the credits rolled.',
        'The visuals, the story, the performances - everything was just perfect.',
        'I could watch it a hundred times and still find new details to appreciate.',
        'A masterpiece that redefines the sci-fi genre.',
      ],
      'imageMovie':
          'https://image.tmdb.org/t/p/original/k3UoZhRHg6h2XYzwNAJJvGC2yev.jpg',
      'availableDate': '2025-10-15',
      'idLike': 1,
    };
  }

  @override
  Future<Map<String, dynamic>> fetchQuantityLikes() async {
    // try {
    //   final RestClientResponse response = await restClient.get('/likes?populate=*');
    //   if (response.statusCode != 200) {
    //     log.log(
    //       'Status code: ${response.statusCode} / Messagem: ${response.statusMessage}',
    //     );
    //     throw Exception(response.statusMessage);
    //   }

    //   return response.data;
    // } catch (e) {
    //   log.log(e.toString());
    //   throw Exception('Erro datasource');
    // }

    await Future.delayed(const Duration(seconds: 1));
    return {'quantity': 123};
  }

  @override
  Future<void> likeMovie({required int userId, required int movieId}) async {
    // try {
    // final RestClientResponse response = await restClient.post('/likes',data: {'movie_id': movieId, 'user_id': userId});
    //   if (response.statusCode != 200) {
    //     log.log(
    //       'Status code: ${response.statusCode} / Messagem: ${response.statusMessage}',
    //     );
    //     throw Exception(response.statusMessage);
    //   }

    //   return response.data;
    // } catch (e) {
    //   log.log(e.toString());
    //   throw Exception('Erro datasource');
    // }
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> unlikeMovie({required int idLike}) async {
    // try {
    //   final RestClientResponse response = await restClient.delete(
    //     '/movie/unlike/$idLike',
    //   );
    //   if (response.statusCode != 200) {
    //     log.log(
    //       'Status code: ${response.statusCode} / Messagem: ${response.statusMessage}',
    //     );
    //     throw Exception(response.statusMessage);
    //   }

    //   return response.data;
    // } catch (e) {
    //   log.log(e.toString());
    //   throw Exception('Erro datasource');
    // }
    await Future.delayed(const Duration(seconds: 1));
  }
}

class HomeDataSourceFirebaseImpl implements HomeDataSource {
  final FirebaseStorage _firebaseStorage;
  HomeDataSourceFirebaseImpl(this._firebaseStorage);
  @override
  Future<Map<String, dynamic>> fetchMovie() {
    // TODO: Implement Firebase logic to fetch movie data
    return Future.value({});
  }

  @override
  Future<Map<String, dynamic>> fetchQuantityLikes() {
    // TODO: Implement Firebase logic to fetch quantity likes
    return Future.value({});
  }

  @override
  Future<void> likeMovie({required int userId, required int movieId}) {
    // TODO: Implement Firebase logic to like a movie
    return Future.value();
  }

  @override
  Future<void> unlikeMovie({required int idLike}) {
    // TODO: Implement Firebase logic to unlike a movie
    return Future.value();
  }
}
