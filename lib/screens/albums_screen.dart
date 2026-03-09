import 'package:flutter/material.dart';
import 'package:smash_music_app/db/functions/add_song_to_hive.dart';
import 'package:smash_music_app/db/model/data_model.dart';
import 'package:smash_music_app/screens/album_details_screen.dart';
import 'package:smash_music_app/widgets/all_color.dart';
import 'package:smash_music_app/widgets/back_button.dart';
import 'package:smash_music_app/widgets/glass_container.dart';

class AlbumsScreen extends StatelessWidget {
  final bool showBackButton;
  
  const AlbumsScreen({super.key, this.showBackButton = true});

  Map<String, List<Music>> _groupByAlbum(List<Music> songs) {
    Map<String, List<Music>> albums = {};
    for (var song in songs) {
      String albumName = song.album ?? 'Unknown Album';
      if (!albums.containsKey(albumName)) {
        albums[albumName] = [];
      }
      albums[albumName]!.add(song);
    }
    return albums;
  }

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
                  "Albums",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder(
                  valueListenable: songsNotifier,
                  builder: (context, List<Music> songs, _) {
                    return Text(
                      "${_groupByAlbum(songs).length} albums",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: songsNotifier,
                    builder: (context, List<Music> songs, child) {
                      if (songs.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.album,
                                size: 80,
                                color: Colors.white.withOpacity(0.3),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'No Albums Found',
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

                      Map<String, List<Music>> albums = _groupByAlbum(songs);
                      List<String> albumNames = albums.keys.toList()
                        ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: albumNames.length,
                        itemBuilder: (context, index) {
                          String albumName = albumNames[index];
                          List<Music> albumSongs = albums[albumName]!;
                          
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AlbumDetailsScreen(
                                    albumName: albumName,
                                    songs: albumSongs,
                                  ),
                                ),
                              );
                            },
                            child: GlassCard(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Album Art
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.purple.withOpacity(0.6),
                                            Colors.deepPurple.withOpacity(0.8),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.purple.withOpacity(0.3),
                                            blurRadius: 8,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.album,
                                          size: 60,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  // Album Name
                                  Text(
                                    albumName,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  // Song Count
                                  Text(
                                    '${albumSongs.length} ${albumSongs.length == 1 ? 'song' : 'songs'}',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
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
