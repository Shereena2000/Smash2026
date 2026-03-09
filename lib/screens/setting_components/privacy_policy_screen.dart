import 'package:flutter/material.dart';
import 'package:smash_music_app/widgets/all_color.dart';
import 'package:smash_music_app/widgets/back_button.dart';
import 'package:smash_music_app/widgets/glass_container.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
                  'Privacy Policy',
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
                
                GlassCard(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Icon(
                        Icons.shield,
                        color: Colors.green.shade300,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Your privacy is very important to us. This Privacy Policy outlines how Smash Music gathers, uses, and safeguards your personal information.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                _buildSection(
                  icon: Icons.file_download,
                  iconColor: Colors.blue.shade300,
                  title: 'Collection of Personal Data',
                  content: 'We may gather personal data, such as details about your device and the songs stored on it, to offer you a customized music experience.',
                ),
                
                const SizedBox(height: 16),
                
                _buildSection(
                  icon: Icons.stars,
                  iconColor: Colors.purple.shade300,
                  title: 'Usage of Personal Data',
                  content: 'We utilize your information to enhance your experience, refine our services, and keep you informed about updates and new features.',
                ),
                
                const SizedBox(height: 16),
                
                _buildSection(
                  icon: Icons.lock,
                  iconColor: Colors.orange.shade300,
                  title: 'Protection of Personal Data',
                  content: 'We do not sell, trade, or otherwise transfer your personal data to third parties without your consent, except as required by law. We employ security measures to safeguard your personal data against unauthorized access and disclosure.',
                ),
                
                const SizedBox(height: 16),
                
                _buildSection(
                  icon: Icons.update,
                  iconColor: Colors.teal.shade300,
                  title: 'Updates to Privacy Policy',
                  content: 'We may update our Privacy Policy from time to time. Please review this policy periodically for changes.',
                ),
                
                const SizedBox(height: 16),
                
                _buildSection(
                  icon: Icons.verified_user,
                  iconColor: Colors.green.shade300,
                  title: 'Agreement to Terms',
                  content: 'By using the Smash Music application, you agree to the terms outlined in this Privacy Policy.',
                ),
                
                const SizedBox(height: 16),
                
                _buildSection(
                  icon: Icons.contact_mail,
                  iconColor: Colors.pink.shade300,
                  title: 'Contact Information',
                  content: 'If you have any questions or concerns about our Terms of Service or Privacy Policy, please contact us at shereenajamezz@gmail.com.',
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
