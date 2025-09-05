import 'package:flutter/services.dart';
import 'package:shopify/data/models/artist/artist.dart';
import 'dart:convert';

abstract class ArtistService {
  Future<List<Artist>> getArtists();
}

class ArtistServiceImpl extends ArtistService {
  @override
  Future<List<Artist>> getArtists() async {
    final jsonString = await rootBundle.loadString('assets/json/data.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final artists = (jsonData['artists'] as List)
      .map((e) => Artist.fromJson(e))
      .toList();
      return artists;
  }

  Future<Artist> getArtistById(String id) async {
    final artists = await getArtists();
    return artists.firstWhere((artist) => artist.id == id);
  }
}
