import 'package:flutter/material.dart';
import 'package:anemia_hemeglobin_app/core/shared/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: primaryColor,
              child: Icon(
                Icons.medical_services,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Anemia Hemoglobin App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Version 1.0.0',
              style: TextStyle(color: hintColor),
            ),
            const SizedBox(height: 30),
            const Text(
              'Our mission is to provide non-invasive anemia and hemoglobin level testing to help people monitor their health easily and conveniently.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            const Text(
              'Development Team',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildTeamMember(
              'Dr. Sarah Johnson',
              'Medical Advisor',
              'assets/images/team1.jpg', // Replace with your image path
              'https://github.com/sarahjohnson',
            ),
            _buildTeamMember(
              'Dr. Sarah Johnson',
              'Medical Advisor',
              'assets/images/team2.jpg', // Replace with your image path
              'https://github.com/sarahjohnson',
            ),
            _buildTeamMember(
              'Alex Chen',
              'Lead Developer',
              'assets/images/team3.jpg', // Replace with your image path
              'https://github.com/alexchen',
            ),
            _buildTeamMember(
              'Maria Garcia',
              'UI/UX Designer',
              'assets/images/team4.jpg', // Replace with your image path
              'https://github.com/mariagarcia',
            ),
            _buildTeamMember(
              'David Kim',
              'Backend Developer',
              'assets/images/team5.jpg', // Replace with your image path
              'https://github.com/davidkim',
            ),
            _buildTeamMember(
              'Emma Wilson',
              'Data Scientist',
              'assets/images/team6.jpg', // Replace with your image path
              'https://github.com/emmawilson',
            ),
            const SizedBox(height: 30),
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // _buildContactButton(
            //   context,
            //   Icons.email,
            //   'Email Us',
            //   'mailto:support@anemiaapp.com',
            // ),
            _buildContactButton(
              context,
              Icons.language,
              'Visit Our Linkdin Profile',
              'https://www.anemiaapp.com',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMember(String name, String role, String imagePath, String githubUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // Team member photo
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(width: 15),
          // Name and role
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  role,
                  style: const TextStyle(
                    fontSize: 14,
                    color: hintColor,
                  ),
                ),
              ],
            ),
          ),
          // GitHub icon button
          IconButton(
            icon: const Icon(Icons.code, color: primaryColor),
            onPressed: () async {
              if (await canLaunchUrl(Uri.parse(githubUrl))) {
                await launchUrl(Uri.parse(githubUrl));
              }
            },
            tooltip: 'View GitHub profile',
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton(
      BuildContext context, IconData icon, String text, String url) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: primaryColor),
          ),
        ),
        icon: Icon(icon),
        label: Text(text),
        onPressed: () async {
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
          }
        },
      ),
    );
  }
}