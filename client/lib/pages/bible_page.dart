import 'package:client/components/custom_navbar.dart';
import 'package:flutter/material.dart';

class BiblePage extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  const BiblePage({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bible"),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Bible Page",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: selectedIndex,
        onItemTapped: onItemTapped,
      ),
    );
  }
}
