import 'package:dartz/dartz.dart';
import 'package:shopify/core/usecase/usecase.dart';
import 'package:shopify/domain/respository/song/song.dart';
import 'package:shopify/service_locator.dart';

class AddOrRemoveFavoriteSongUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongsRepository>().addOrRemoveFavoriteSongs(params!);
  }
}
