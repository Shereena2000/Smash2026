import 'package:flutter/material.dart';
import 'package:smash_music_app/widgets/all_color.dart';
import 'package:smash_music_app/widgets/back_button.dart';
import 'package:smash_music_app/widgets/glass_container.dart';

class TandCScreen extends StatelessWidget {
  const TandCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundColor(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
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
                  'Terms & Conditions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Last updated: November 2025',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 30),
                
                _buildSection(
                  icon: Icons.waving_hand,
                  iconColor: Colors.orange.shade300,
                  title: 'Welcome to Smash Music!',
                  content: 'These terms of service ("Terms") govern your use of the Smash Music application and its services. By using the Smash Music application, you agree to comply with and be bound by these Terms.',
                ),
                
                const SizedBox(height: 16),
                
                _buildSection(
                  icon: Icons.security,
                  iconColor: Colors.green.shade300,
                  title: 'User Responsibilities',
                  content: 'Users are solely responsible for the content they upload, share, or otherwise make available on the Smash Music application. Please ensure you have the necessary rights to any content you use.',
                ),
                
                const SizedBox(height: 16),
                
                _buildSection(
                  icon: Icons.copyright,
                  iconColor: Colors.blue.shade300,
                  title: 'Intellectual Property',
                  content: 'The Smash Music application and its content are protected by copyright and other intellectual property laws. You may not reproduce, distribute, modify, or create derivative works without our prior written consent.',
                ),
                
                const SizedBox(height: 16),
                
                _buildSection(
                  icon: Icons.gavel,
                  iconColor: Colors.red.shade300,
                  title: 'Termination',
                  content: 'We reserve the right to terminate or suspend your access to the Smash Music application at any time without prior notice if you violate these Terms.',
                ),
                
                const SizedBox(height: 30),
                
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.withOpacity(0.3),
                          Colors.deepPurple.withOpacity(0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    child: const Text(
                      'Thank you for using Smash Music!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildSection({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
  }) {
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
