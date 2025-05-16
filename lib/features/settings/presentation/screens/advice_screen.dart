import 'package:flutter/material.dart';
import 'package:anemia_hemeglobin_app/core/shared/styles/colors.dart';

class AdviceScreen extends StatelessWidget {
  const AdviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Advice'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAdviceSection(
              'For People with Anemia',
              [
                '• Eat iron-rich foods (red meat, poultry, fish, lentils, beans)',
                '• Consume vitamin C with meals to enhance iron absorption',
                '• Avoid tea/coffee during meals as they inhibit iron absorption',
                '• Consider iron supplements if recommended by your doctor',
                '• Get adequate rest and manage fatigue',
              ],
            ),
            _buildAdviceSection(
              'For Maintaining Good Health',
              [
                '• Eat a balanced diet with variety of vegetables and fruits',
                '• Exercise regularly (30 mins/day)',
                '• Get 7-8 hours of quality sleep each night',
                '• Stay hydrated (2-3 liters of water daily)',
                '• Get regular health checkups',
              ],
            ),
            _buildAdviceSection(
              'For Low Hemoglobin Levels',
              [
                '• Increase iron and folate intake',
                '• Avoid excessive dairy consumption',
                '• Eat small, frequent meals',
                '• Address potential underlying causes',
                '• Monitor levels regularly',
              ],
            ),
            _buildAdviceSection(
              'For High Hemoglobin Levels',
              [
                '• Stay well hydrated',
                '• Avoid smoking',
                '• Monitor oxygen levels',
                '• Consult a doctor if persistently high',
                '• Consider altitude effects',
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Note: This advice is general. Always consult with a healthcare professional for personal medical advice.',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdviceSection(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(item),
          )),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}