import 'package:client/services/day_tracker.dart';
import 'package:flutter/material.dart';

/*
idea for this card. basically have 5-10 books of the Bible on standby. 
3 of them will be randomly picked everyday to show here. the card will 
have all three of them, with a power line/hook at the top to get the 
reader interested to learn more (which there will be a button for)
and a one sentence summnary of either what to expect or the book itself,
possibly being cut off to get the user to click the button. once the 
learn more button is picked, a popup will show up will the finished 
summary a way for the user to read the actual book (routes/switches 
the page to the book of the bible in the bible page).
*/

class RecommendBooks extends StatefulWidget {
  const RecommendBooks({super.key});

  @override
  State<RecommendBooks> createState() => _RecommendBooksState();
}

class _RecommendBooksState extends State<RecommendBooks> {
  final DayTrackerService _dayTrackerService = DayTrackerService();
  bool _isNewDay = false;

  @override
  void initState() {
    super.initState();
    _checkIfNewDay();
  }

  Future<void> _checkIfNewDay() async {
    bool result = await _dayTrackerService.isNewDay();
    if (mounted) {
      setState(() {
        _isNewDay = result;
      });

      if (_isNewDay) {
        // do the random function thing
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}

// smaller class for each book
class Book extends StatelessWidget {
  const Book({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
