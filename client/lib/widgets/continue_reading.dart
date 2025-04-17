import 'package:flutter/material.dart';

class ContinueReading extends StatefulWidget {
  const ContinueReading({super.key});

  @override
  State<ContinueReading> createState() => _ContinueReadingState();
}

class _ContinueReadingState extends State<ContinueReading> {
  // late bool _loading;
  double _progressValue = 0.6;

  @override
  void initState() {
    super.initState();
    // _loading = false;
    // _progressValue = 0.6;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Continue Reading?",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text("John - Chapter 3", style: TextStyle(fontSize: 20)),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.play_circle_outline_sharp, size: 45),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).colorScheme.primary,
                  ),
                  value: _progressValue,
                ),
                SizedBox(height: 4),
                Text('${(_progressValue * 100).round()}%'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
