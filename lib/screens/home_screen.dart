import 'package:flutter/material.dart';
import 'package:smash_music_app/screens/albums_screen.dart';
import 'package:smash_music_app/screens/artists_screen.dart';
import 'package:smash_music_app/screens/favorite_screen.dart';
import 'package:smash_music_app/screens/recently_played_screen.dart';
import 'package:smash_music_app/screens/settings_screen.dart';
import 'package:smash_music_app/screens/tab_screen/playlist_screen.dart';
import 'package:smash_music_app/screens/tab_screen/song_screen.dart';
import 'package:smash_music_app/song_component/all_songs.dart';
import 'package:smash_music_app/widgets/add_playlist.dart';
import 'package:smash_music_app/widgets/all_color.dart';
import 'package:smash_music_app/widgets/glass_container.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundColor(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              // App Bar with Greeting
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getGreeting(),
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Music Lover',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SettingScreen()));
                            },
                            child: GlassContainer(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.all(12),
                              blur: 15,
                              opacity: 0.2,
                              borderRadius: BorderRadius.circular(15),
                              child: const Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                  //-----------favourite-------------//
                  GlassCard(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FavoriteScreen(showBackButton: true))),
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.pink.withOpacity(0.6),
                                Colors.purple.withOpacity(0.6),
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          'Favorite Songs',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                      // Quick Actions Section
                      _buildSectionHeader(context, 'Quick Actions', null),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildQuickActionCard(
                              context,
                              'Recently Played',
                              Icons.history,
                              Colors.orange,
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RecentlyPlayedScreen(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildQuickActionCard(
                              context,
                              'My Playlist',
                              Icons.playlist_play,
                              Colors.blue,
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SongScreen(
                                    initialTabIndex: 1,
                                    showBackButton: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildQuickActionCard(
                              context,
                              'Albums',
                              Icons.album,
                              Colors.purple,
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AlbumsScreen(showBackButton: true),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildQuickActionCard(
                              context,
                              'Artists',
                              Icons.person,
                              Colors.pink,
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ArtistsScreen(showBackButton: true),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Playlists Section
                      _buildSectionHeader(context, 'My Playlists', null),
                      const SizedBox(height: 12),
                      AddPlaylist(
                        onPlaylistCreated: (playlistName) {
                          PlaylistManager.playlistNames.add(playlistName);
                        },
                      ),
                      const SizedBox(height: 20),
                      // All Songs Section
                      _buildSectionHeader(
                        context,
                        'All Songs',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SongScreen(
                              initialTabIndex: 0,
                              showBackButton: true,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              // Songs List
              const SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverToBoxAdapter(
                  child: AllSongs(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning 🌅';
    } else if (hour < 17) {
      return 'Good Afternoon ☀️';
    } else if (hour < 21) {
      return 'Good Evening 🌆';
    } else {
      return 'Good Night 🌙';
    }
  }

  Widget _buildSectionHeader(BuildContext context, String title, VoidCallback? onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        if (onTap != null)
          GestureDetector(
            onTap: onTap,
            child: GlassContainer(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              blur: 10,
              opacity: 0.15,
              borderRadius: BorderRadius.circular(12),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        blur: 12,
        opacity: 0.15,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(0.6),
                    color.withOpacity(0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
