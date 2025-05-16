import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:anemia_hemeglobin_app/core/shared/local/cache_helper.dart';
import 'package:anemia_hemeglobin_app/features/auth/presentation/screens/login_screen.dart';
import 'package:anemia_hemeglobin_app/features/onboarding/data/on_boarding_model.dart';
import 'package:anemia_hemeglobin_app/features/onboarding/presentation/widgets/on_boarding_item.dart';

import '../../../../core/shared/styles/colors.dart';
import '../../../../core/utils/navigation_helper.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _skipOnBoarding(BuildContext context) {
    CacheHelper.setData(key: 'onBoarding', value: true).then((_) {
      NavigationHelper.pushReplacement(context, LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: boardingItems.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                return OnBoardingItem(model: boardingItems[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: boardingItems.length,
                  effect: const WormEffect(
                    activeDotColor: primaryColor,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (_currentPage == boardingItems.length - 1) {
                      _skipOnBoarding(context);
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  backgroundColor: primaryColor,
                  child: Icon(
                    _currentPage == boardingItems.length - 1
                        ? Icons.check
                        : Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}