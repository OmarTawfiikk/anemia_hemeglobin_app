import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anemia_hemeglobin_app/core/shared/styles/colors.dart';
import 'package:anemia_hemeglobin_app/core/shared/local/database_helper.dart';
import 'package:anemia_hemeglobin_app/features/auth/presentation/cubit/auth_cubit.dart';

import '../../../auth/presentation/cubit/auth_state.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> _testHistory = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final state = context.read<AuthCubit>().state;
    if (state is LoginSuccess) {
      final history = await DatabaseHelper.getTestHistory(state.authModel.data!.id);
      setState(() {
        _testHistory = history;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test History'),
      ),
      body: _testHistory.isEmpty
          ? const Center(
        child: Text('No test history available'),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _testHistory.length,
        itemBuilder: (context, index) {
          final test = _testHistory[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        test['testType'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        test['date'],
                        style: const TextStyle(color: hintColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Result: ${test['result']}'),
                  if (test['imagePath'] != null) ...[
                    const SizedBox(height: 8),
                    Image.asset(
                      test['imagePath'],
                      height: 100,
                    ),
                  ],
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: errorColor),
                      onPressed: () async {
                        await DatabaseHelper.deleteTestHistory(test['id']);
                        _loadHistory();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}