import 'package:shopify/core/usecase/usecase.dart';
import 'package:shopify/domain/respository/song/song.dart';
import 'package:shopify/service_locator.dart';

class IsFavoriteSongUseCase implements UseCase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongsRepository>().isFavoriteSong(params!);
  }
}
