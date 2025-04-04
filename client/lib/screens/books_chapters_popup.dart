import 'package:client/services/bible_service.dart';
import 'package:flutter/material.dart';

class BooksChaptersPopup extends StatelessWidget {
  final bibleService = BibleService();

  BooksChaptersPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            var books = snapshot.data;
            return ListView.builder(
              itemCount: books?.length,
              itemBuilder: (context, index) {
                var book = books?[index];
                return ExpansionTile(
                  title: Text(book?["name"] ?? "Unknown"),
                  children: List.generate(int.parse(book!["num_chapters"]!), (
                    chapterIndex,
                  ) {
                    return ListTile(
                      title: Text("${chapterIndex + 1}"),
                      onTap: () {},
                    );
                  }),
                );
              },
            );
          }
        },
      ),
    );
  }
}
