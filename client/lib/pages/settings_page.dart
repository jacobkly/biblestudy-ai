import 'package:client/components/custom_navbar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;
  final VoidCallback? onThemeChanged;

  const SettingsPage({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.onThemeChanged,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;

  void _themeModeChange() {
    setState(() {
      isDarkMode = !isDarkMode;
    });

    if (widget.onThemeChanged != null) {
      widget.onThemeChanged!(); // notify parent if callback exists
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            tooltip: "Toggle Theme",
            onPressed: _themeModeChange,
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "Settings Page",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: widget.selectedIndex,
        onItemTapped: widget.onItemTapped,
      ),
    );
  }
}

// class SettingsPage extends StatelessWidget {
//   final int selectedIndex;
//   final void Function(int) onItemTapped;

//   const SettingsPage({
//     super.key,
//     required this.selectedIndex,
//     required this.onItemTapped,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Settings"),
//         backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
//             tooltip: "Toggle Theme",
//             onPressed: themeModeChange,
//           ),
//         ],
//       ),
//       body: const Center(
//         child: Text(
//           "Settings Page",
//           style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//         ),
//       ),
//       bottomNavigationBar: CustomNavBar(
//         selectedIndex: selectedIndex,
//         onItemTapped: onItemTapped,
//       ),
//     );
//   }
// }
