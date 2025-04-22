import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'plant_identification_screen.dart';
import 'gardening_tips_screen.dart';
import 'community_forum_screen.dart';
import 'local_resources_screen.dart';
import 'marketplace_screen.dart';

// HomeScreen widget with BottomNavigationBar as per Design Doc Section 5.3
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // To track the active tab

  // List of the screens corresponding to each tab
  static const List<Widget> _widgetOptions = <Widget>[
    Semantics(
      label: 'Plant Identification Screen', // Semantic label for accessibility
      child: PlantIdentificationScreen(), // Index 0
    ),
    Semantics(
      label: 'Gardening Tips Screen', // Semantic label for accessibility
      child: GardeningTipsScreen(), // Index 1
    ),
    Semantics(
      label: 'Community Forum Screen', // Semantic label for accessibility
      child: CommunityForumScreen(), // Index 2
    ),
    Semantics(
      label: 'Local Resources Screen', // Semantic label for accessibility
      child: LocalResourcesScreen(), // Index 3
    ),
    Semantics(
      label: 'Marketplace Screen', // Semantic label for accessibility
      child: MarketplaceScreen(), // Index 4
    ),
  ];

  // Function called when a tab is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build the HomeScreen widget
    return Scaffold(
      // The body will display the widget from _widgetOptions based on the selected index
      // We use IndexedStack to preserve the state of each screen when switching tabs
      body: Semantics(
        label: 'Home Screen Content', // Semantic label for the main content area
        child: IndexedStack(
          index: _selectedIndex, // Use _selectedIndex to determine which screen to display
          children: _widgetOptions, // The list of screens to choose from
        ),
      ),
      // Implement the BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist_outlined), // Outline icon when inactive
            activeIcon: Icon(Icons.local_florist), // Filled icon when active
            label: 'Identify',
            tooltip: 'Identify Plants', // Tooltip for accessibility
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            activeIcon: Icon(Icons.lightbulb),
            label: 'Tips',
            tooltip: 'Gardening Tips', // Tooltip for accessibility
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum_outlined),
            activeIcon: Icon(Icons.forum),
            label: 'Forum',
            tooltip: 'Community Forum', // Tooltip for accessibility
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'Resources',
            tooltip: 'Local Resources', // Tooltip for accessibility
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            activeIcon: Icon(Icons.storefront),
            label: 'Market',
            tooltip: 'Marketplace', // Tooltip for accessibility
          ),
        ],
        currentIndex: _selectedIndex, // The current selected tab
        // Use theme colors for selected and unselected items
        selectedItemColor: Theme.of(context).colorScheme.primary, // Color for the selected tab
        unselectedItemColor: Colors.grey[600], // A slightly darker grey for unselected
        // Add labels to selected items for clarity
        // showUnselectedLabels: false, // Optionally hide labels for unselected items
        onTap: _onItemTapped, // Call _onItemTapped when a tab is tapped
        // Type fixed ensures all items are visible and have consistent spacing
        type: BottomNavigationBarType.fixed, // BottomNavigationBarType.fixed to display all labels
        // Apply background color from theme if needed (defaults to theme canvasColor)
        // backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}
