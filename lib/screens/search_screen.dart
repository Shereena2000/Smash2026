import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smash_music_app/db/functions/add_song_to_hive.dart';
import 'package:smash_music_app/db/model/data_model.dart';
import 'package:smash_music_app/song_component/song_tile.dart';
import 'package:smash_music_app/widgets/all_color.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Music> searchMusic = [];
  late Box<Music> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<Music>('musicbox');
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
                // Row(
                //   children: [
                //     const PreviousButton(),
                //     const Spacer(),
                //   ],
                // ),
                const SizedBox(height: 20),
                const Text(
                  "Search",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Find your favorite songs",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.25),
                        Colors.white.withOpacity(0.15),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: TextField(
                    onSubmitted: (value) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    controller: searchController,
                    onChanged: (value) {
                      searchMusic.clear();
                      for (var song in songsNotifier.value) {
                        if (song.title
                            .toLowerCase()
                            .contains(value.toLowerCase())) {
                          searchMusic.add(song);
                        }
                      }
                      setState(() {});
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Search songs...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(child: buildSongList())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSongList() {
    return ValueListenableBuilder(
      valueListenable: songsNotifier,
      builder: (context, List<Music> songs, child) {
        if (songs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.music_off,
                  size: 80,
                  color: Colors.white.withOpacity(0.3),
                ),
                const SizedBox(height: 20),
                Text(
                  'No Music Found',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add songs to your device',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }
        if (searchController.text.isNotEmpty && searchMusic.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 80,
                  color: Colors.white.withOpacity(0.3),
                ),
                const SizedBox(height: 20),
                Text(
                  'No Results Found',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Try a different search term',
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
          itemCount: searchController.text.isNotEmpty
              ? searchMusic.length
              : songs.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final Music song = searchController.text.isNotEmpty
                ? searchMusic[index]
                : songs[index];
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
