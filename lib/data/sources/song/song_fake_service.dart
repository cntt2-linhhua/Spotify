import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:shopify/data/models/song/song_2.dart';

abstract class SongService {
  Future<Either> getArtists();
}

class SongServiceImpl extends SongService {
  @override
  Future<Either> getArtists() async {
    try {
      final jsonString = await rootBundle.loadString('assets/json/data.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final artists = (jsonData['songs'] as List)
      .map((e) => SongV2.fromJson(e))
      .toList();

      return Right(artists);
    } catch (e) {
      return const Left('An error occurred, please try again.'); 
    }
  }

  Future<List<SongV2>> getSongsByArtist(String artistId) async {
    final songs = await getArtists();
    return songs.fold(
      (l) => [],
      (r) => r.where((song) => song.artistId == artistId).toList(),
    );
  }
}
