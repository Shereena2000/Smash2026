import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smash_music_app/db/functions/playlist_func.dart';
import 'package:smash_music_app/db/model/playlist_model.dart';
import 'package:smash_music_app/widgets/add_playlist.dart';
import 'package:smash_music_app/widgets/constant.dart';
import 'package:smash_music_app/widgets/playlist_tile.dart';


class PlaylistTab extends StatefulWidget {
  const PlaylistTab({super.key});

  @override
  State<PlaylistTab> createState() => _PlaylistTabState();
}

class _PlaylistTabState extends State<PlaylistTab> {
  // static List<String> playlistNames = [];
  late Box playistBox;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playistBox = Hive.box<Playlist>('playlistBox');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Add Playlist Button
        Row(
          children: [
            AddPlaylist(
              onPlaylistCreated: (playlistName) {
                setState(() {
                  PlaylistManager.playlistNames.add(playlistName);
                });
              },
            ),
            const SizedBox(width: 12),
            const Text(
              'Add New Playlist',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Playlists List
        Expanded(
          child: ValueListenableBuilder(
              valueListenable: playlistNotifier,
              builder: (context, playlist, child) {
                if (playlist.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.playlist_add,
                          size: 80,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'No Playlists Yet',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Create your first playlist',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: playlist.length,
                  itemBuilder: (context, index) {
                    return PlaylistFolder(
                      playlistObj: playlist[index],
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 12);
                  },
                );
              }),
        ),
      ],
    );
  }
}

class PlaylistManager {
  static List<String> playlistNames = [];
}
