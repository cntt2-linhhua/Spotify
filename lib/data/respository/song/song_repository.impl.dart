import 'package:dartz/dartz.dart';
import 'package:shopify/data/sources/song/song_firebase_service.dart';
import 'package:shopify/domain/respository/song/song.dart';
import 'package:shopify/service_locator.dart';

class SongRespositoryImpl extends SongsRepository {
  @override
  Future<Either> getNewsSongs() async {
	  return await sl<SongFirebaseService>().getNewsSongs();
  }
  
  @override
  Future<Either> getPlayList() async {
    return await sl<SongFirebaseService>().getPlayList();
  }
  
  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    return await sl<SongFirebaseService>().addOrRemoveFavoriteSongs(songId);
  }
  
  @override
  Future<bool> isFavoriteSong(String songId) async {
    return await sl<SongFirebaseService>().isFavoriteSong(songId);
  }
  
  @override
  Future<Either> getUserFavoriteSongs() async {
    return await sl<SongFirebaseService>().getUserFavoriteSongs();
  }
}
