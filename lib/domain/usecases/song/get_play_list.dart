import 'package:dartz/dartz.dart';
import 'package:shopify/core/usecase/usecase.dart';
import 'package:shopify/data/sources/song/song_firebase_service.dart';
import 'package:shopify/service_locator.dart';

class GetPlayListUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongFirebaseService>().getPlayList();
  }
}
