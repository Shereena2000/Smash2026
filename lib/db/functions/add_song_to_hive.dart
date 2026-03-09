import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smash_music_app/db/model/data_model.dart';


ValueNotifier<List<Music>> songsNotifier = ValueNotifier([]);

//add song to hive
class AddSongsToHive extends ChangeNotifier {
  static Future<void> addSongToHive(List<Music> songs) async {
    songsNotifier.value.clear();
    final box = Hive.box<Music>('musicbox');
    await box.addAll(songs);
    songsNotifier.value.addAll(songs);
    songsNotifier.notifyListeners();
  }
}
