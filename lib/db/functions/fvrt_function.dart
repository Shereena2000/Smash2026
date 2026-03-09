import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smash_music_app/db/functions/add_song_to_hive.dart';
import 'package:smash_music_app/db/model/data_model.dart';


ValueNotifier<List<Music>> favoriteNotifier = ValueNotifier([]);

class FavoriteFunctions extends ChangeNotifier {
  //store hive reference
  static final favoriteBox = Hive.box<int>('favoriteBox');

  // add to favourites
  static Future<void> addToFavorite({required Music song}) async {
    await favoriteBox.add(song.id);
    favoriteNotifier.value.add(song);
    favoriteNotifier.notifyListeners();
  }

// retrive all songs from hive
  static Future<void> readFavSongs() async {
    favoriteNotifier.value.clear();
    for (var song in songsNotifier.value) {
      if (isFavour(song)) {
        favoriteNotifier.value.add(song);
      }
    }
    favoriteNotifier.notifyListeners();

  }

//  check the song contain favouritebox
  static bool isFavour(Music song) {
    if (favoriteBox.values.contains(song.id)) {
      return true;
    }
    return false;
  }

static Future<void> deleteFromFav(int songId)async{
  int deleteKey =0;
  if (!favoriteBox.values.contains(songId)) {
    return;
  }
  final Map<dynamic,int> favorMap =favoriteBox.toMap();
  favorMap.forEach((key, value) {
    if (value== songId) {
      deleteKey =key;
    }
  });
  await favoriteBox.delete(deleteKey);
  await readFavSongs();
}

}
