import 'dart:convert';

import 'package:client/components/custom_navbar.dart';
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
  var _genOne;

  void fetchGenesisOne() async {
    try {
      // android emulator endpoint URL
      final response = await http.get(
        Uri.parse("http://10.0.2.2:8000/api/bible/chapters/GEN.1"),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));

        setState(() {
          _genOne = jsonData["content"];
        });
      } else {
        print("Failed to load content. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching Bible content: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchGenesisOne();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bible"),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        centerTitle: true,
      ),
      body:
          _genOne == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Html(
                    data: _genOne, // The content from the API
                    style: {
                      "p": Style(
                        fontSize: FontSize.larger,
                        lineHeight: LineHeight.number(1.5),
                        padding: HtmlPaddings.only(bottom: 10),
                      ),
                      "span.v": Style(
                        fontSize: FontSize.medium,
                        color: Colors.blueAccent, // Styles verse numbers
                      ),
                    },
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
