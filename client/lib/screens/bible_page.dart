import 'dart:convert';

import 'package:client/widgets/book_chapter_indicator.dart';
import 'package:client/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

class BiblePage extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  const BiblePage({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<BiblePage> createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {
  String selectedChapterId = "GEN.1"; // default book and chapter
  String selectedChapterName = "Genesis 1"; // default book name and chapter
  String? nextChapterId;
  String? previousChapterId;
  String? chapterData;

  void onChapterSelected(Map<String, dynamic> chapter) {
    setState(() {
      selectedChapterId = "${chapter["book_id"]}.${chapter["chapter_num"]}";
    });
    fetchBibleChapter();
  }

  void fetchBibleChapter() async {
    try {
      // android emulator endpoint URL
      final response = await http.get(
        Uri.parse("http://10.0.2.2:8000/api/bible/chapters/$selectedChapterId"),
      );

      if (response.statusCode == 200) {
        final jsonRes = jsonDecode(utf8.decode(response.bodyBytes));

        setState(() {
          chapterData = jsonRes["content"];
          selectedChapterName = jsonRes["reference"];
          nextChapterId = jsonRes["next_id"];
          previousChapterId = jsonRes["previous_id"];
        });
      } else {
        print("Failed to load content. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching Bible content: $error");
    }
  }

  void loadPreviousChapter() {
    if (previousChapterId != null && previousChapterId != "GEN.intro") {
      setState(() {
        selectedChapterId = previousChapterId!;
      });
      fetchBibleChapter();
    }
  }

  void loadNextChapter() {
    if (nextChapterId != null) {
      setState(() {
        selectedChapterId = nextChapterId!;
      });
      fetchBibleChapter();
    }
  }

  @override
  void initState() {
    super.initState();
    if (chapterData == null) {
      fetchBibleChapter();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selectedChapterId != "GEN.1"
                ? IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: loadPreviousChapter,
                  iconSize: 30,
                )
                : SizedBox(width: 48),
            SizedBox(width: 16),
            BookChapterIndicator(
              selectedChapter: selectedChapterName,
              onChapterSelected: onChapterSelected,
            ),
            SizedBox(width: 16),
            selectedChapterId != "REV.22"
                ? IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: loadNextChapter,
                  iconSize: 30,
                )
                : SizedBox(width: 48),
          ],
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            loadNextChapter();
          } else if (details.primaryVelocity! > 0) {
            loadPreviousChapter();
          }
        },
        child:
            chapterData == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Html(
                      data: chapterData,
                      style: {
                        "p": Style(
                          fontSize: FontSize.larger,
                          lineHeight: LineHeight.number(1.5),
                          padding: HtmlPaddings.only(bottom: 10),
                        ),
                        "sup": Style(
                          fontSize: FontSize.medium,
                          verticalAlign: VerticalAlign.sup,
                        ),
                      },
                    ),
                  ),
                ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: widget.selectedIndex,
        onItemTapped: widget.onItemTapped,
      ),
    );
  }
}
