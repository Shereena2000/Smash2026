import 'package:flutter/material.dart';
import 'package:smash_music_app/core/theme/theme_manager.dart';
import 'package:smash_music_app/widgets/all_color.dart';
import 'package:smash_music_app/widgets/back_button.dart';
import 'package:smash_music_app/widgets/glass_container.dart';

class ThemeSelectionScreen extends StatefulWidget {
  const ThemeSelectionScreen({super.key});

  @override
  State<ThemeSelectionScreen> createState() => _ThemeSelectionScreenState();
}

class _ThemeSelectionScreenState extends State<ThemeSelectionScreen> {
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
                  'Choose Theme',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Select your favorite color theme',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildThemeOption(
                        theme: AppTheme.purple,
                        name: 'Purple Dream',
                        description: 'Classic purple elegance',
                        colors: [Colors.purple.shade300, Colors.deepPurple.shade700],
                      ),
                      const SizedBox(height: 12),
                      _buildThemeOption(
                        theme: AppTheme.blue,
                        name: 'Ocean Blue',
                        description: 'Calm and serene blue',
                        colors: [Colors.blue.shade300, Colors.indigo.shade700],
                      ),
                      const SizedBox(height: 12),
                      _buildThemeOption(
                        theme: AppTheme.green,
                        name: 'Nature Green',
                        description: 'Fresh and natural green',
                        colors: [Colors.green.shade300, Colors.teal.shade700],
                      ),
                      const SizedBox(height: 12),
                      _buildThemeOption(
                        theme: AppTheme.orange,
                        name: 'Sunset Orange',
                        description: 'Warm sunset vibes',
                        colors: [Colors.orange.shade300, Colors.deepOrange.shade700],
                      ),
                      const SizedBox(height: 12),
                      _buildThemeOption(
                        theme: AppTheme.pink,
                        name: 'Pink Blossom',
                        description: 'Sweet and lovely pink',
                        colors: [Colors.pink.shade300, Colors.pinkAccent.shade700],
                      ),
                      const SizedBox(height: 12),
                      _buildThemeOption(
                        theme: AppTheme.red,
                        name: 'Ruby Red',
                        description: 'Bold and energetic red',
                        colors: [Colors.red.shade300, Colors.redAccent.shade700],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeOption({
    required AppTheme theme,
    required String name,
    required String description,
    required List<Color> colors,
  }) {
    final isSelected = themeManager.currentTheme == theme;

    return GestureDetector(
      onTap: () async {
        await themeManager.setTheme(theme);
        setState(() {});
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Theme changed to $name'),
              duration: const Duration(seconds: 2),
              backgroundColor: colors[1],
            ),
          );
        }
      },
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Color Preview
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors,
                ),
                boxShadow: [
                  BoxShadow(
                    color: colors[1].withOpacity(0.4),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Theme Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Selection Indicator
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: colors,
                  ),
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                ),
              )
            else
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


