import 'package:flutter/material.dart';
import 'package:smash_music_app/db/functions/recent_song_func.dart';
import 'package:smash_music_app/db/model/data_model.dart';
import 'package:smash_music_app/song_component/song_tile.dart';
import 'package:smash_music_app/widgets/all_color.dart';
import 'package:smash_music_app/widgets/back_button.dart';
import 'package:smash_music_app/widgets/constant.dart';


class RecentlyPlayedScreen extends StatefulWidget {
  const RecentlyPlayedScreen({super.key});

  @override
  State<RecentlyPlayedScreen> createState() => _RecentlyPlayedScreenState();
}

class _RecentlyPlayedScreenState extends State<RecentlyPlayedScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundColor(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const PreviousButton(),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Recently Played",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Your listening history",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: recentlyNotifier,
                    builder: (BuildContext context, List<Music> recentlySongs,
                        Widget? child) {
                      if (recentlySongs.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.history,
                                size: 80,
                                color: Colors.white.withOpacity(0.3),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'No Recently Played Songs',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Start playing songs to see history',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.4),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      // Reverse the list to show most recent first
                      final reversedSongs = recentlySongs.reversed.toList();
                      return ListView.builder(
                          itemCount: reversedSongs.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final song = reversedSongs[index];
                            return SongTile(
                              songName: song.title,
                              musicObj: song,
                              index: index,
                              artistName: song.artist ?? 'Unknown',
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
