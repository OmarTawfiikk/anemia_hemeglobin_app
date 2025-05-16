import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anemia_hemeglobin_app/core/shared/styles/colors.dart';
import 'package:anemia_hemeglobin_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:anemia_hemeglobin_app/features/auth/presentation/screens/login_screen.dart';
import 'package:anemia_hemeglobin_app/features/settings/presentation/screens/advice_screen.dart';
import 'package:anemia_hemeglobin_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:anemia_hemeglobin_app/core/providers/theme_provider.dart';
import 'package:anemia_hemeglobin_app/core/utils/navigation_helper.dart';

import '../../../auth/presentation/cubit/auth_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSettingsItem(
            context,
            'Profile',
            Icons.person,
                () {
              NavigationHelper.push(context, const ProfileScreen());
            },
          ),
          _buildSettingsItem(
            context,
            'Dark Mode',
            Icons.dark_mode,
            null,
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
          ),
          _buildSettingsItem(
            context,
            'Health Advice',
            Icons.medical_services,
                () {
              NavigationHelper.push(context, const AdviceScreen());
            },
          ),
          const SizedBox(height: 20),
          _buildLogoutButton(context, authCubit),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
      BuildContext context,
      String title,
      IconData icon,
      VoidCallback? onTap, {
        Widget? trailing,
      }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        trailing: trailing ?? const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, AuthCubit authCubit) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          NavigationHelper.pushReplacement(context, LoginScreen());
        }
      },
      builder: (context, state) {
        return ElevatedButton.icon(
          icon: const Icon(Icons.logout),
          label: state is AuthLoading
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(color: Colors.white),
          )
              : const Text('Logout'),
          style: ElevatedButton.styleFrom(
            backgroundColor: errorColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: state is AuthLoading
              ? null
              : () {
            _showLogoutConfirmationDialog(context, authCubit);
          },
        );
      },
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context, AuthCubit authCubit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              authCubit.logout();
            },
            child: const Text('Logout', style: TextStyle(color: errorColor)),
          ),
        ],
      ),
    );
  }
}