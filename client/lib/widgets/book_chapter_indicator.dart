import 'package:client/screens/books_chapters_popup.dart';
import 'package:flutter/material.dart';

class BookChapterIndicator extends StatelessWidget {
  const BookChapterIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BooksChaptersPopup()),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceBright,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.inverseSurface,
          ),
        ),
        child: Text(
          "Genesis 1",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inverseSurface,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
