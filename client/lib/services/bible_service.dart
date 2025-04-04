import 'package:http/http.dart' as http;
import 'dart:convert';

class BibleService {
  // Singleton pattern in Dart
  static final BibleService _instance = BibleService._internal();
  factory BibleService() => _instance;

  BibleService._internal();

  List<Map<String, String>> _books = [];
  bool _isLoaded = false;

  // Load the Bible structure data from the API
  Future<void> loadBibleStructureData() async {
    if (_isLoaded) return;

    final response = await http.get(
      Uri.parse("http://10.0.2.2:8000/api/bible/books/chapters"),
    );

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      _books = List<Map<String, String>>.from(
        decodedResponse.map(
          (item) => {
            'id': item['id'].toString(),
            'name': item['name'].toString(),
            'num_chapters': item['num_chapters'].toString(),
          },
        ),
      );
      _isLoaded = true;
    } else {
      throw Exception("Failed to load Bible data");
    }
  }

  // Get the Bible structure data
  Future<List<Map<String, String>>> getBibleStructureData() async {
    if (!_isLoaded) {
      await loadBibleStructureData();
    }
    return _books;
  }
}
