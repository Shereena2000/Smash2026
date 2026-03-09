import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smash_music_app/db/functions/add_song_to_hive.dart';
import 'package:smash_music_app/db/model/data_model.dart';
import 'package:smash_music_app/song_component/song_tile.dart';
import 'package:smash_music_app/widgets/constant.dart';

class AllSongs extends StatefulWidget {
  const AllSongs({super.key});

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  late Box<Music> box;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box = Hive.box<Music>('musicbox');
  }

  @override
  Widget build(BuildContext context) {
    return allSongs();
  }

  Widget allSongs() {
    return ValueListenableBuilder(
        valueListenable: songsNotifier,
        builder: (context, List<Music> songs, child) {
          if (songs.isEmpty) {
            return const Center(
              child: Text('No music found',style: normalText),          
            );
          }
          // Only show first 10 songs on home screen for better performance
          final displaySongs = songs.length > 10 ? songs.sublist(0, 10) : songs;
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: displaySongs.length,
              itemBuilder: (context, index) {
                final Music song = displaySongs[index];
                return SongTile(
                    songName: song.title, 
                    musicObj: song, 
                    index: index,
                    artistName: song.artist ?? 'Unknown',
                );
              });
        });
  }
}
