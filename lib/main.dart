import 'package:flutter/material.dart';
import 'plant_identification_screen.dart';
import 'gardening_tips_screen.dart';
import 'community_forum_screen.dart';
import 'local_resources_screen.dart';
import 'marketplace_screen.dart';

void main() {
  runApp(const EVAAgriculturaUrbanaApp());
}

class EVAAgriculturaUrbanaApp extends StatelessWidget {
  const EVAAgriculturaUrbanaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EVA Agricultura Urbana',
      theme: ThemeData(
              // Define the default brightness and colors.
              brightness: Brightness.light, // Switch between light and dark modes.
              primaryColor: Colors.green[700], // Main brand color
              // Define a text theme for the app.
              textTheme: const TextTheme(
                bodyText2: TextStyle(fontSize: 16.0, color: Colors.black87), // Body text
              ),
              // Define AppBar theme with improved contrast
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.green[700], // Use primary color
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: const IconThemeData(color: Colors.white), // Ensure icons are visible
                foregroundColor: Colors.white, // Use onPrimary color
                elevation: 4.0, // Add subtle shadow
                centerTitle: true, // Center align AppBar titles for consistency
              ),
              // Define Button Themes for consistency
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  // Use primary color for main action buttons by default
                  backgroundColor: Colors.green[700], 
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                ).copyWith(
                  // Overlay color to improve contrast on pressed state
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.green[900]; // Darker shade for pressed state
                      }
                      return null; // Use the default value.
                    },
                  ),
                ),
              ),
              // Add other theme customizations (CardTheme, InputDecoratioTheme, etc.)
            ),
            // Set the initial route to the HomeScreen
            home: const HomeScreen(),
            // Define routes for potential named navigation (optional for now)
            // routes: {
            //   '/home': (context) => HomeScreen(),
            //   '/plant_id': (context) => PlantIdentificationScreen(),
            //   '/gardening_tips': (context) => GardeningTipsScreen(),
            //   '/forum': (context) => CommunityForumScreen(),
            // },
          );
        }
      }
