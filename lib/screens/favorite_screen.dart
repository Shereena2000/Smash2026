import 'package:flutter/material.dart';
import 'package:smash_music_app/db/functions/fvrt_function.dart';
import 'package:smash_music_app/db/model/data_model.dart';
import 'package:smash_music_app/song_component/song_tile.dart';
import 'package:smash_music_app/widgets/all_color.dart';
import 'package:smash_music_app/widgets/back_button.dart';

class FavoriteScreen extends StatelessWidget {
  final bool showBackButton;
  
  const FavoriteScreen({super.key, this.showBackButton = true});

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
                  "Favourite Songs",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "My Soundtrack",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: favoriteNotifier,
                      builder: (context, List<Music> favSongs, child) {
                        if (favSongs.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  size: 80,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'No Favourite Songs Yet',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Add songs to your favourites',
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
                            itemCount: favSongs.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return SongTile(
                                  artistName: favSongs[index].artist ?? 'Unknown',
                                  songName: favSongs[index].title,
                                  musicObj: favSongs[index],
                                  index: index);
                            });
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
