import 'package:flutter/material.dart';
import 'package:smash_music_app/db/model/data_model.dart';
import 'package:smash_music_app/screens/play_song_screen.dart';
import 'package:smash_music_app/widgets/trailing_popup.dart';
import 'package:smash_music_app/widgets/glass_container.dart';


class SongTile extends StatelessWidget {
  final String songName;
  final Music musicObj;
  final int index;
 final String artistName;
  const SongTile({
    super.key,
    required this.songName,
    required this.musicObj,
    required this.index, required this.artistName,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaySongScreen(
              musicObj: musicObj,
              index: index,
            ),
          ),
        );
      },
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          // Album art with glass effect
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/music.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              width: 55.0,
              height: 55.0,
            ),
          ),
          const SizedBox(width: 12),
          // Song info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  songName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  artistName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          PopUp(song: musicObj),
        ],
      ),
    );
  }
}
