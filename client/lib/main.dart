import 'package:client/screens/bible_page.dart';
import 'package:client/screens/home_page.dart';
import 'package:client/screens/settings_page.dart';
import 'package:client/services/bible_service.dart';
import 'package:client/utils/app_theme.dart';
import 'package:client/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BibleService().loadBibleStructureData();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Widget _setScreen() {
  //   switch (_selectedIndex) {
  //     case 0:
  //       return HomePage(
  //         selectedIndex: _selectedIndex,
  //         onItemTapped: _onItemTapped,
  //       );
  //     case 1:
  //       return BiblePage(
  //         selectedIndex: _selectedIndex,
  //         onItemTapped: _onItemTapped,
  //       );
  //     case 2:
  //       return SettingsPage(
  //         selectedIndex: _selectedIndex,
  //         onItemTapped: _onItemTapped,
  //         onThemeChanged: toggleTheme,
  //       );
  //     default:
  //       return HomePage(
  //         selectedIndex: _selectedIndex,
  //         onItemTapped: _onItemTapped,
  //       );
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
      BiblePage(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
      SettingsPage(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        onThemeChanged: toggleTheme,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      darkTheme: AppTheme.dark,
      theme: AppTheme.light,
      home: Scaffold(
        body: IndexedStack(index: _selectedIndex, children: _pages),
        bottomNavigationBar: CustomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
