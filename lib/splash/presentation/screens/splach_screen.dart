import 'package:flutter/material.dart';
import 'package:anemia_hemeglobin_app/core/shared/local/cache_helper.dart';
import 'package:anemia_hemeglobin_app/features/auth/presentation/screens/login_screen.dart';
import 'package:anemia_hemeglobin_app/features/onboarding/presentation/screens/on_boarding_screen.dart';

import '../../../core/shared/styles/colors.dart';
import '../../../core/utils/navigation_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    final bool isFirstTime = CacheHelper.getData(key: 'onBoarding') ?? true;

    if (isFirstTime) {
      NavigationHelper.pushReplacement(context, const OnBoardingScreen());
      await CacheHelper.setData(key: 'onBoarding', value: false);
    } else {
      NavigationHelper.pushReplacement(context, LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [primaryColor, secondaryColor],
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 2000,
            height: 2000,
          ),
        ),
      ),
    );
  }
}