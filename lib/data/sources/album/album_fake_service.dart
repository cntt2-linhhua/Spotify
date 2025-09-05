import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:shopify/data/models/album/album.dart';
import 'dart:convert';

abstract class AlbumService {
  Future<Either> getAlbums();
}

class AlbumServiceImpl extends AlbumService {
  @override
  Future<Either> getAlbums() async {
    try {
      final jsonString = await rootBundle.loadString('assets/json/data.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final artists = (jsonData['albums'] as List)
      .map((e) => Album.fromJson(e))
      .toList();

      return Right(artists);
    } catch (e) {
      return const Left('An error occurred, please try again.'); 
    }
  }

  Future<List<Album>> getAlbumsByArtist(String artistId) async {
    final albums = await getAlbums();
    return albums.fold(
      (l) => [],
      (r) => r.where((album) => album.artistId == artistId).toList(),
    );
  }
}
