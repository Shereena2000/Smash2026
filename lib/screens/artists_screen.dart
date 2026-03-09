import 'package:flutter/material.dart';
import 'package:smash_music_app/db/functions/add_song_to_hive.dart';
import 'package:smash_music_app/db/model/data_model.dart';
import 'package:smash_music_app/screens/artist_details_screen.dart';
import 'package:smash_music_app/widgets/all_color.dart';
import 'package:smash_music_app/widgets/back_button.dart';
import 'package:smash_music_app/widgets/glass_container.dart';

class ArtistsScreen extends StatelessWidget {
  final bool showBackButton;
  
  const ArtistsScreen({super.key, this.showBackButton = true});

  Map<String, List<Music>> _groupByArtist(List<Music> songs) {
    Map<String, List<Music>> artists = {};
    for (var song in songs) {
      String artistName = song.artist ?? 'Unknown Artist';
      if (!artists.containsKey(artistName)) {
        artists[artistName] = [];
      }
      artists[artistName]!.add(song);
    }
    return artists;
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
                  "Artists",
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
                      "${_groupByArtist(songs).length} artists",
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
                                Icons.person,
                                size: 80,
                                color: Colors.white.withOpacity(0.3),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'No Artists Found',
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

                      Map<String, List<Music>> artists = _groupByArtist(songs);
                      List<String> artistNames = artists.keys.toList()
                        ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: artistNames.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          String artistName = artistNames[index];
                          List<Music> artistSongs = artists[artistName]!;
                          
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArtistDetailsScreen(
                                    artistName: artistName,
                                    songs: artistSongs,
                                  ),
                                ),
                              );
                            },
                            child: GlassCard(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  // Artist Avatar
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.blue.withOpacity(0.6),
                                          Colors.purple.withOpacity(0.8),
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
                                        Icons.person,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  // Artist Info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          artistName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${artistSongs.length} ${artistSongs.length == 1 ? 'song' : 'songs'}',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.6),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: Colors.white.withOpacity(0.5),
                                    size: 28,
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
