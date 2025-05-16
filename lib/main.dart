import 'package:anemia_hemeglobin_app/splash/presentation/screens/splach_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:anemia_hemeglobin_app/core/providers/theme_provider.dart';
import 'package:anemia_hemeglobin_app/core/shared/local/cache_helper.dart';
import 'package:anemia_hemeglobin_app/core/shared/styles/themes.dart';
import 'package:anemia_hemeglobin_app/features/auth/auth_injection.dart';
import 'package:anemia_hemeglobin_app/features/auth/presentation/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  setupAuthDependencies();

  // Create the ThemeProvider instance and load preferences before runApp
  final themeProvider = ThemeProvider();
  await themeProvider.loadThemePref();

  runApp(
    ChangeNotifierProvider<ThemeProvider>.value(
      value: themeProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>()),
      ],
      child: MaterialApp(
        title: 'Anemia Hemoglobin App',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeProvider.themeMode,
        home: const SplashScreen(),
      ),
    );
  }
}
