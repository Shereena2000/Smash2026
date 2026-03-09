
import 'package:on_audio_query/on_audio_query.dart';
import 'package:smash_music_app/db/model/data_model.dart';

   // convert songModel to music
List<Music> changeSongModel(List<SongModel> songModel){
List<Music> songs =[];
for (var song in songModel) {
  songs.add(Music(id: song.id, path: song.data, title: song.title,album: song.album ?? "unknown",artist: song.artist),);
}
return songs;
}