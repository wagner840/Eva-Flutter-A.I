import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

// Represents the Plant Identification screen based on eva_app_design_document.txt
class PlantIdentificationScreen extends StatefulWidget {
  const PlantIdentificationScreen({Key? key}) : super(key: key);

  @override
  _PlantIdentificationScreenState createState() =>
      _PlantIdentificationScreenState();
}

class _PlantIdentificationScreenState extends State<PlantIdentificationScreen> {
  File? _image;
  String _plantInfo = 'Take a picture or select one to identify a plant.';
  bool _isLoading = false; // To show a loading indicator
  final picker = ImagePicker();

  // Function to pick an image from gallery or camera
  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _plantInfo = 'Image selected. Ready to identify.'; // Update status
      } else {
        print('No image selected.');
        // Keep previous state if no image is picked
      }
    });
  }

  // Function to call the plant identification API
  Future<void> _identifyPlant() async {
    if (_image == null) {
      setState(() {
        _plantInfo = 'Please select an image first.';
      });
      return;
    }

    setState(() {
      _isLoading = true; // Start loading
      _plantInfo = 'Identifying plant...';
    });

    // IMPORTANT: Replace with your actual PlantNet API key
    // Store API keys securely, not directly in code for production apps.
    // Consider using environment variables or a secrets management solution.
    String apiKey = 'YOUR_PLANTNET_API_KEY'; // <-- !!! REPLACE AND SECURE THIS KEY !!!

    // PlantNet API endpoint
    // Use 'all' for general identification, or specify organs like 'leaf', 'flower', 'fruit', 'bark'
    final uri = Uri.parse('https://my-api.plantnet.org/v2/identify/all?api-key=$apiKey');

    try {
      // Create a multipart request
      var request = http.MultipartRequest('POST', uri);
      
      // Add the image file
      request.files.add(await http.MultipartFile.fromPath(
        'images', // API expects the file field named 'images'
         _image!.path,
         // filename: _image!.path.split('/').last // Optional: filename
      ));

      // Add other parameters if needed (e.g., organs)
      // request.fields['organs'] = 'leaf'; 

      print('Sending request to PlantNet API...');
      var response = await request.send();
      print('Response status code: ${response.statusCode}');


      if (response.statusCode == 200) {
        // Read response stream
        var responseBody = await response.stream.bytesToString();
         print('API Response Body: $responseBody'); // Log raw response for debugging
        var decodedResponse = jsonDecode(responseBody);

        // Process the response - structure depends on the API (PlantNet example)
        if (decodedResponse['results'] != null && decodedResponse['results'].isNotEmpty) {
           // Get the top result
           var topResult = decodedResponse['results'][0];
           String scientificName = topResult['species']['scientificNameWithoutAuthor'] ?? 'N/A';
           String commonName = (topResult['species']['commonNames'] as List).isNotEmpty 
                               ? topResult['species']['commonNames'][0] 
                               : 'No common name found';
           double score = topResult['score'] ?? 0.0;

           // Update the UI
           setState(() {
             // Use triple quotes for multi-line string
             _plantInfo = '''Identified: $commonName ($scientificName)
Confidence: ${(score * 100).toStringAsFixed(1)}%''';
             // TODO: Add more details or actions based on the identified plant
           });
        } else {
           setState(() {
             _plantInfo = 'Could not identify the plant. Try a clearer picture or different angle.';
           });
        }
      } else {
         // Handle non-200 responses
         var errorBody = await response.stream.bytesToString();
         print('API Error: ${response.statusCode} - $errorBody');
         setState(() {
           _plantInfo = 'Error identifying plant. Status Code: ${response.statusCode}. Please try again.';
         });
      }
    } catch (e) {
       print('Error calling PlantNet API: $e');
       setState(() {
         _plantInfo = 'An error occurred: $e. Check connection or API key.';
       });
    } finally {
       setState(() {
         _isLoading = false; // Stop loading regardless of outcome
       });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Accessing theme for consistent styling (as per design doc)
    final theme = Theme.of(context); 
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Identification'),
        // Theme colors are applied automatically via appBarTheme in main.dart
      ),
      body: SingleChildScrollView( // Allow scrolling if content overflows
        padding: const EdgeInsets.all(16.0), // Add padding around content
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch buttons
            children: <Widget>[
              // Display selected image or placeholder
              Container(
                height: 250, // Fixed height for the image container
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  // Use a subtle background color from the theme
                  color: theme.colorScheme.surfaceVariant, 
                ),
                child: _image == null
                    ? Center(child: Text('No Image Selected', style: theme.textTheme.titleMedium))
                    : ClipRRect( // Clip image to rounded corners
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(_image!, fit: BoxFit.cover, semanticLabel: 'Selected plant image'),
                      ),
              ),
              const SizedBox(height: 20),

              // Buttons for picking image
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _getImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Take Photo'),
                    // Style buttons using theme (can override default if needed)
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.secondary,
                      foregroundColor: theme.colorScheme.onSecondary,
                    ),
                  ),
                  ElevatedButton.icon(
                     onPressed: () => _getImage(ImageSource.gallery),
                     icon: const Icon(Icons.photo_library),
                     label: const Text('Gallery'),
                     style: ElevatedButton.styleFrom(
                       backgroundColor: theme.colorScheme.secondary,
                       foregroundColor: theme.colorScheme.onSecondary,
                     ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Button to trigger identification
              ElevatedButton.icon(
                 // Disable button while loading or if no image
                onPressed: (_image == null || _isLoading) ? null : _identifyPlant, 
                icon: const Icon(Icons.search),
                label: const Text('Identify Plant'),
                // Uses default ElevatedButton theme from main.dart 
                // (primary color, padding, shape)
              ),
              const SizedBox(height: 20),

              // Display identification results or loading indicator
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                         color: theme.colorScheme.surfaceVariant.withOpacity(0.5), // Slightly transparent background
                         borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        _plantInfo,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge, // Use theme text style
                      ),
                    ),
               // TODO: Add links or buttons for next actions:
               // - Save plant to user's garden (requires Firebase/Supabase integration)
               // - View detailed care information (could fetch from another API or local DB)
               // - Connect to marketplace (future enhancement)
            ],
          ),
        ),
      ),
    );
  }
}
