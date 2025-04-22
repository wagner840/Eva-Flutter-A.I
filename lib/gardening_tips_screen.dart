import 'package:flutter/material.dart';

class GardeningTipsScreen extends StatelessWidget {
  const GardeningTipsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gardening Tips'),
      ),
      body: const Center(
        child: Text('Gardening Tips - Coming Soon!'),
      ),
    );
  }
}
