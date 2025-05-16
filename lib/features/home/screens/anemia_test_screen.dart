import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/shared/styles/colors.dart';

class AnemiaTestScreen extends StatefulWidget {
  const AnemiaTestScreen({super.key});

  @override
  State<AnemiaTestScreen> createState() => _AnemiaTestScreenState();
}

class _AnemiaTestScreenState extends State<AnemiaTestScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _palmImage;
  XFile? _nailsImage;
  XFile? _eyeImage;
  String? _selectedTest;
  String? _testResult;

  Future<void> _pickImage(String testType) async {
    if (_selectedTest != null && _selectedTest != testType) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'You can only upload an image for the "$_selectedTest" test. Please reset to choose another.',
          ),
        ),
      );
      return;
    }

    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedTest = testType;
          switch (testType) {
            case 'palm':
              _palmImage = image;
              break;
            case 'nails':
              _nailsImage = image;
              break;
            case 'eye':
              _eyeImage = image;
              break;
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void _resetTestSelection() {
    setState(() {
      _palmImage = null;
      _nailsImage = null;
      _eyeImage = null;
      _selectedTest = null;
      _testResult = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final sampleImageColor = isDarkMode ? Colors.grey[800]! : Colors.grey[200]!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,  // for text and icon color
        title: const Text('Anemia Test'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetTestSelection,
            tooltip: 'Reset Test Selection',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose only one test method 🙏🏼',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Palm Test Section
            _buildTestSection(
              context,
              'Upload your Palm please 🖐🏼',
              'assets/images/palm_sample.png',
              'Palm Sample',
              _palmImage,
                  () => _pickImage('palm'),
              sampleImageColor,
              _selectedTest != null && _selectedTest != 'palm',
            ),
            const SizedBox(height: 30),

            // Nails Test Section
            _buildTestSection(
              context,
              'Upload your Nails please 💅🏼',
              'assets/images/nails_sample.webp',
              'Nails Sample',
              _nailsImage,
                  () => _pickImage('nails'),
              sampleImageColor,
              _selectedTest != null && _selectedTest != 'nails',
            ),
            const SizedBox(height: 30),

            // Eye Test Section
            _buildTestSection(
              context,
              'Upload your Eye please 👁',
              'assets/images/eye_sample.jpg',
              'Eye Sample',
              _eyeImage,
                  () => _pickImage('eye'),
              sampleImageColor,
              _selectedTest != null && _selectedTest != 'eye',
            ),
            const SizedBox(height: 40),

            // Submit Button
            if (_palmImage != null || _nailsImage != null || _eyeImage != null)
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  onPressed: () {
                    setState(() {
                      _testResult = 'Your test result: Normal'; // Replace with actual logic
                    });
                  },
                  child: const Text('Submit Test', style: TextStyle(color: Colors.white)),
                ),
              ),
            const SizedBox(height: 20),

            // Result Display Box
            if (_testResult != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  _testResult!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestSection(
      BuildContext context,
      String title,
      String sampleImagePath,
      String label,
      XFile? userImage,
      VoidCallback onPickImage,
      Color sampleImageColor,
      bool isDisabled,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDisabled
                      ? Colors.grey
                      : Theme.of(context).colorScheme.surface,
                  foregroundColor: isDisabled
                      ? Colors.black26
                      : Theme.of(context).colorScheme.onSurface,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                icon: const Icon(Icons.upload),
                label: Text(userImage == null ? 'Upload Image' : 'Image Selected'),
                onPressed: isDisabled ? null : onPickImage,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: sampleImageColor,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(sampleImagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        if (userImage != null) ...[
          const SizedBox(height: 10),
          Text(
            'Selected: ${userImage.name}',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ],
    );
  }
}
