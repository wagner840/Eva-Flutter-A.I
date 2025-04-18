import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EVA Agricultura Urbana',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
      routes: {
        '/plant_id': (context) => PlantIdentificationScreen(),
        '/gardening_tips': (context) => GardeningTipsScreen(),
        '/community_forum': (context) => CommunityForumScreen(),
        '/local_resources': (context) => LocalResourcesScreen(),
        '/marketplace': (context) => MarketplaceScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EVA Agricultura Urbana'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Plant Identification'),
              onPressed: () { Navigator.pushNamed(context, '/plant_id'); },
            ),
            ElevatedButton(
              child: Text('Gardening Tips'),
              onPressed: () { Navigator.pushNamed(context, '/gardening_tips'); },
            ),
            ElevatedButton(
              child: Text('Community Forum'),
              onPressed: () { Navigator.pushNamed(context, '/community_forum'); },
            ),
            ElevatedButton(
              child: Text('Local Resources'),
              onPressed: () { Navigator.pushNamed(context, '/local_resources'); },
            ),
            ElevatedButton(
              child: Text('Marketplace'),
              onPressed: () { Navigator.pushNamed(context, '/marketplace'); },
            ),
          ],
        ),
      ),
    );
  }
}

class PlantIdentificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plant Identification')),
      body: Center(child: Text('Plant Identification Screen')),
    );
  }
}

class GardeningTipsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gardening Tips')),
      body: Center(child: Text('Gardening Tips Screen')),
    );
  }
}

class CommunityForumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Community Forum')),
      body: Center(child: Text('Community Forum Screen')),
    );
  }
}

class LocalResourcesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Local Resources')),
      body: Center(child: Text('Local Resources Screen')),
    );
  }
}

class MarketplaceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Marketplace')),
      body: Center(child: Text('Marketplace Screen')),
    );
  }
}
