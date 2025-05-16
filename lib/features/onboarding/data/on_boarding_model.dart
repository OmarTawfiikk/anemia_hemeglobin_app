class OnBoardingModel {
  final String image;
  final String title;
  final String description;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnBoardingModel> boardingItems = [
  OnBoardingModel(
    image: 'assets/images/onboarding1.png',
    title: 'Welcome to Anemia Hemoglobin App',
    description: 'Track your anemia status and hemoglobin levels easily',
  ),
  OnBoardingModel(
    image: 'assets/images/onboarding2.png',
    title: 'Non-Invasive Testing',
    description: 'Get accurate results without blood tests',
  ),
  OnBoardingModel(
    image: 'assets/images/onboarding3.png',
    title: 'Health Insights',
    description: 'Understand your results with detailed analysis',
  ),
];