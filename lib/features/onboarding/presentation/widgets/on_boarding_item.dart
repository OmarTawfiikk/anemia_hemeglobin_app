import 'package:flutter/material.dart';
import 'package:anemia_hemeglobin_app/features/onboarding/data/on_boarding_model.dart';

import '../../../../core/shared/styles/colors.dart';

class OnBoardingItem extends StatelessWidget {
  final OnBoardingModel model;

  const OnBoardingItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            model.image,
            height: 300,
          ),
          const SizedBox(height: 40),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              model.description,
              style: const TextStyle(
                fontSize: 16,
                color: hintColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}