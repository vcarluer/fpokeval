import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokeval/providers/card_analysis_provider.dart';
import 'package:pokeval/providers/search_history_provider.dart';
import 'package:pokeval/screens/home_screen.dart';
import 'package:pokeval/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CardAnalysisProvider()),
        ChangeNotifierProvider(create: (_) => SearchHistoryProvider()),
      ],
      child: MaterialApp(
        title: 'Pokeval',
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}