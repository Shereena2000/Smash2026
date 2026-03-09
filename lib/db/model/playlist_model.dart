import 'package:hive_flutter/hive_flutter.dart';
import 'package:smash_music_app/db/model/data_model.dart';

part 'playlist_model.g.dart'; 

@HiveType(typeId: 1)
class Playlist extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<Music> songs;

  Playlist({required this.name,required this.songs});
}
