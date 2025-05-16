// lib/features/home/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:anemia_hemeglobin_app/core/shared/styles/colors.dart';
import 'package:anemia_hemeglobin_app/core/utils/navigation_helper.dart';
import 'package:anemia_hemeglobin_app/features/settings/presentation/screens/about_us_screen.dart';
import 'package:anemia_hemeglobin_app/features/settings/presentation/screens/settings_screen.dart';
import 'anemia_test_screen.dart';
import 'hemoglobin_test_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? Colors.grey[800] : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              NavigationHelper.push(context, const SettingsScreen());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Select Test Type',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: _buildTestCard(
                      context,
                      'Anemia Test',
                      Icons.bloodtype,
                      cardColor!,
                          () {
                        NavigationHelper.push(context, const AnemiaTestScreen());
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildTestCard(
                      context,
                      'Hemoglobin Test',
                      Icons.monitor_heart,
                      cardColor!,
                          () {
                        NavigationHelper.push(context, const HemoglobinTestScreen());
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image.asset(
                    'assets/images/home_illustration.webp',
                    fit: BoxFit.contain,
                    color: isDarkMode ? Colors.white.withOpacity(0.8) : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        backgroundColor: Theme.of(context).cardColor,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About Us',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            NavigationHelper.push(context, const AboutUsScreen());
          } else if (index == 2) {
            NavigationHelper.push(context, const SettingsScreen());
          }
        },
      ),
    );
  }

  Widget _buildTestCard(
      BuildContext context,
      String title,
      IconData icon,
      Color cardColor,
      VoidCallback onTap,
      ) {
    return Card(
      elevation: 5,
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(icon, size: 50, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
