import 'package:client/screens/books_chapters_popup.dart';
import 'package:flutter/material.dart';

class BookChapterIndicator extends StatelessWidget {
  final String selectedChapter;
  final Function(Map<String, dynamic>) onChapterSelected;

  const BookChapterIndicator({
    super.key,
    required this.selectedChapter,
    required this.onChapterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BooksChaptersPopup()),
        );
        if (result != null && result is Map<String, dynamic>) {
          onChapterSelected(result);
        }
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
          selectedChapter,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inverseSurface,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
