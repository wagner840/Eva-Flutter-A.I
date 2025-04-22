import 'package:flutter/material.dart';

class LocalResourcesScreen extends StatelessWidget {
  const LocalResourcesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Resources'),
      ),
      body: const Center(
        child: Text('Local Resources - Coming Soon!'),
      ),
    );
  }
}
