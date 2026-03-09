import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smash_music_app/db/model/data_model.dart';
import 'package:smash_music_app/db/model/playlist_model.dart';


ValueNotifier<List<Playlist>> playlistNotifier = ValueNotifier([]);

class PlaylistFunc extends ChangeNotifier {
  static final playlistBox = Hive.box<Playlist>('playlistBox');

  static Future<void> createPlaylistFolder(String name, BuildContext context) async {
    if (playlistBox.values.any((playlist) => playlist.name == name)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Playlist name already exists!'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.red,
      ));
      return;
    }
    final playlist = Playlist(name: name, songs: []);
    await playlistBox.add(playlist);
    playlistNotifier.value.add(playlist);
    playlistNotifier.notifyListeners();
  }

  static Future<void> getPlaylist() async {
    playlistNotifier.value.clear();
    playlistNotifier.value.addAll(playlistBox.values);
    playlistNotifier.notifyListeners();
  }

  static Future<void> updateFolderName(int index, String name) async {
    final playlist = playlistBox.getAt(index);
    playlist!.name = name;
    await playlistBox.putAt(index, playlist);
    playlistNotifier.value = playlistBox.values.toList();
    playlistNotifier.notifyListeners();
  }

  static Future<void> deletePlaylist(int index) async {
    playlistBox.deleteAt(index);
    playlistNotifier.value.removeAt(index);
    playlistNotifier.notifyListeners();
  }

  static Future<void> addSongToPlaylist(
      int index, Music song, BuildContext context) async {
    final playlist = playlistBox.getAt(index);
    if (playlist!.songs.contains(song)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Already Added!'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    playlist.songs.add(song);
    await playlistBox.putAt(index, playlist);
    playlistNotifier.value = playlistBox.values.toList();
    playlistNotifier.notifyListeners();
  }

  static Future<void> deleteSongFromPlaylist(int index, int songIndex) async {
    final playlistFolder = playlistBox.getAt(index);
    playlistFolder!.songs.removeAt(songIndex);
    await playlistBox.putAt(index, playlistFolder);
    playlistNotifier.value = playlistBox.values.toList();
    playlistNotifier.notifyListeners();
  }
}
