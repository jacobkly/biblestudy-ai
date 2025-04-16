import 'package:client/widgets/continue_reading.dart';
import 'package:client/widgets/daily_verse.dart';
import 'package:client/widgets/recommend_books.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [DailyVerse(), ContinueReading(), RecommendBooks()],
        ),
      ),
    );
  }
}
