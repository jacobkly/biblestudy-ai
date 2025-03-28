import 'package:client/components/navigation_menu.dart';
import 'package:client/pages/bible_page.dart';
import 'package:client/pages/settings_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final VoidCallback? onThemeChanged;

  const HomePage({super.key, this.onThemeChanged});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = false;
  int _selectedIndex = 0;

  void themeModeChange() {
    setState(() {
      widget.onThemeChanged?.call();
      isDarkMode = !isDarkMode;
    });
  }

  final List<Widget> _pages = [
    Center(child: Text("Home Page", style: TextStyle(fontSize: 24))),
    BiblePage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceBright,
        title: Text("Home"),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            tooltip: "Toggle Theme",
            onPressed: themeModeChange,
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationMenu(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
      ),
    );
  }
}
