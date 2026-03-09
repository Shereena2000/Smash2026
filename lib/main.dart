import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smash_music_app/db/functions/add_song_to_hive.dart';
import 'package:smash_music_app/db/functions/change_song_model.dart';
import 'package:smash_music_app/db/functions/fvrt_function.dart';
import 'package:smash_music_app/db/functions/playlist_func.dart';
import 'package:smash_music_app/db/functions/recent_song_func.dart';
import 'package:smash_music_app/db/model/data_model.dart';
import 'package:smash_music_app/db/model/playlist_model.dart';
import 'package:smash_music_app/screens/main_navigation_screen.dart';
import 'package:smash_music_app/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter<Music>(MusicAdapter());
  Hive.registerAdapter<Playlist>(PlaylistAdapter());

  //open box
  await Hive.openBox<Music>('musicbox');
  await Hive.openBox<int>('recentlyBox');
  await Hive.openBox<Playlist>('playlistBox');
  await Hive.openBox<int>('favoriteBox');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  bool _hasPermission = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Don't block - let UI load first
    Future.microtask(() => _initializeApp());
  }

  Future<void> _initializeApp() async {
    try {
      // Small delay to let splash screen show
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Check permission status first (non-blocking)
      PermissionStatus status = await Permission.audio.status;
      
      if (!status.isGranted) {
        // Request permission
        status = await Permission.audio.request();
      }
      
      if (status.isGranted) {
        _hasPermission = true;
        
        // Load songs in background without blocking UI
        _loadSongsInBackground();
      } else if (status.isPermanentlyDenied) {
        _hasPermission = false;
        if (mounted) {
          setState(() => _isLoading = false);
        }
        // Show dialog to open settings
        _showPermissionDialog();
      } else {
        _hasPermission = false;
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    } catch (e) {
      debugPrint('Error initializing app: $e');
      _hasPermission = false;
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _loadSongsInBackground() async {
    try {
      // Query songs
      final songModel = await _audioQuery.querySongs();
      
      // Process in smaller chunks to avoid blocking
      final songs = changeSongModel(songModel);
      
      // Add to Hive
      await AddSongsToHive.addSongToHive(songs);
      
      // Load other data
      await Future.wait([
        RecentlyFunctions.readRecentSongs(),
        PlaylistFunc.getPlaylist(),
        FavoriteFunctions.readFavSongs(),
      ]);
      
      if (mounted) {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      debugPrint('Error loading songs: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showPermissionDialog() {
    // This will be shown in the UI
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SMASH MUSIC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: _isLoading
          ? const SplashScreen()
          : _hasPermission
              ? const MainNavigationScreen()
              : _buildPermissionScreen(),
    );
  }

  Widget _buildPermissionScreen() {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E1E2E),
              Color(0xFF2D1B69),
              Color(0xFF5B2C9C),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.music_note,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Permission Required',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'SMASH MUSIC needs access to your audio files to play music',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    setState(() => _isLoading = true);
                    await _initializeApp();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Grant Permission',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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

