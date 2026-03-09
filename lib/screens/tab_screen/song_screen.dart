import 'package:flutter/material.dart';
import 'package:smash_music_app/db/functions/add_song_to_hive.dart';
import 'package:smash_music_app/db/model/data_model.dart';
import 'package:smash_music_app/screens/tab_screen/playlist_screen.dart';
import 'package:smash_music_app/song_component/song_tile.dart';
import 'package:smash_music_app/widgets/all_color.dart';
import 'package:smash_music_app/widgets/back_button.dart';


class SongScreen extends StatelessWidget {
  final int initialTabIndex;
  final bool showBackButton;
  
  const SongScreen({
    super.key, 
    required this.initialTabIndex,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Songs', 'Playlist'];
    return DefaultTabController(
      initialIndex: initialTabIndex,
      length: tabs.length,
      child: BackgroundColor(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showBackButton)
                    Row(
                      children: [
                        const PreviousButton(),
                        const Spacer(),
                      ],
                    ),
                  if (showBackButton) const SizedBox(height: 20),
                  if (!showBackButton) const SizedBox(height: 10),
                  const Text(
                    "My Music",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Your music library",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 25),
                  // TabBar for Songs and Playlist
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.15),
                          Colors.white.withOpacity(0.08),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.withOpacity(0.6),
                            Colors.deepPurple.withOpacity(0.4),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white.withOpacity(0.6),
                      dividerColor: Colors.transparent,
                      tabs: tabs
                          .map(
                            (tab) => Tab(
                              child: Text(
                                tab,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // TabBarView to switch content
                  const Expanded(
                    child: TabBarView(
                      children: [
                        SongsTab(),
                        PlaylistTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SongsTab extends StatelessWidget {
  const SongsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: songsNotifier,
      builder: (context, List<Music> songs, child) {
        if (songs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.music_note,
                  size: 80,
                  color: Colors.white.withOpacity(0.3),
                ),
                const SizedBox(height: 20),
                Text(
                  'No Songs Found',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add music to your device',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: songs.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final Music song = songs[index];
            return SongTile(
              songName: song.title,
              musicObj: song,
              index: index,
              artistName: song.artist ?? 'Unknown',
            );
          },
        );
      },
    );
  }
}
