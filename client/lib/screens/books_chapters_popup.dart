import 'package:client/services/bible_service.dart';
import 'package:flutter/material.dart';

class BooksChaptersPopup extends StatelessWidget {
  final bibleService = BibleService();

  BooksChaptersPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Theme.of(context).colorScheme.inverseSurface,
            size: 35,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder(
        future: bibleService.getBibleStructureData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No books available'));
          } else {
            var booksChapters = snapshot.data;
            return ListView.builder(
              itemCount: booksChapters?.length,
              itemBuilder: (context, index) {
                var chapter = booksChapters?[index];
                return ExpansionTile(
                  title: Text(chapter?["name"] ?? "Unknown"),
                  children: [
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1,
                          ),
                      itemCount: int.parse(chapter!["num_chapters"]!),
                      itemBuilder: (context, chapterIndex) {
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Navigator.pop(context, {
                              "book_id": chapter["id"],
                              "book_name": chapter["name"],
                              "chapter_num": chapterIndex + 1,
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "${chapterIndex + 1}",
                              style: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
