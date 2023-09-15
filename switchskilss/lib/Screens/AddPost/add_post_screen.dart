import 'package:flutter/material.dart';
import '../../components/background.dart';
import '../../responsive.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../user_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';


class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: Responsive(
          desktop: DesktopAddPostScreen(),
          mobile: MobileAddPostScreen(
            
          ),
        ),
      ),
    );
  }
}

class DesktopAddPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [],
    );
  }
}

class MobileAddPostScreen extends StatefulWidget {

  @override
  _MobileAddPostScreenState createState() => _MobileAddPostScreenState();
}


class _MobileAddPostScreenState extends State<MobileAddPostScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  
  List<String> selectedSkills = [];
  List<String> selectedRegions = [];
  List<String> allSkills = [];
  List<String> allRegions = [];

  final TextEditingController skillsController = TextEditingController();
  final TextEditingController regionsController = TextEditingController();
  
  final String backendUrl = 'https://ethereal-yen-394407.ew.r.appspot.com/';
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  File? _image;
  String? _uploadedImageUrl;

  final picker = ImagePicker();

  @override
  void initState() {
  super.initState();

  _loadSkills();
  _loadRegions();

  titleController = TextEditingController();
  descriptionController = TextEditingController();
  locationController = TextEditingController();
  }

  void _loadSkills() async {
    try {
      List<String> skills = await fetchAllSkills();
      setState(() {
        allSkills = skills;
      });
    } catch (e) {
      print("Error fetching skills: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching skills: $e')),
      );
    }
  }

  void _loadRegions() async {
    try {
      List<String> regions = await fetchAllRegions();
      setState(() {
        allRegions = regions;
      });
    } catch (e) {
      print("Error fetching regions: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching regions: $e')),
      );
    }
  }


  String fullUrl(String route) {
    return backendUrl + route;
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Title',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: locationController,
            decoration: InputDecoration(
              labelText: 'Job Location',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          
          TypeAheadFormField<String>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: skillsController,
              decoration: InputDecoration(
                labelText: 'Skills',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
              ),
            ),
            suggestionsCallback: (pattern) {
              return allSkills.where((skill) => skill.toLowerCase().contains(pattern.toLowerCase())).toList();
            },
            itemBuilder: (context, String suggestion) {
              return ListTile(
                title: Text(suggestion),
              );
            },
            onSuggestionSelected: (String suggestion) {
              setState(() {
                if (!selectedSkills.contains(suggestion)) {
                  selectedSkills.add(suggestion);
                }
                skillsController.clear();
              });
            },
          ),

          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: selectedSkills.map((skill) {
              return Chip(
                label: Text(skill),
                onDeleted: () {
                  setState(() {
                    selectedSkills.remove(skill);
                  });
                },
                deleteIcon: Icon(Icons.close),
              );
            }).toList(),
          ),

          
          TypeAheadFormField<String>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: regionsController,
              decoration: InputDecoration(
                labelText: 'Regions',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
              ),
            ),
            suggestionsCallback: (pattern) {
              return allRegions.where((region) => region.toLowerCase().contains(pattern.toLowerCase())).toList();
            },
            itemBuilder: (context, String suggestion) {
              return ListTile(
                title: Text(suggestion),
              );
            },
            onSuggestionSelected: (String suggestion) {
              setState(() {
                if (!selectedRegions.contains(suggestion)) {
                  selectedRegions.add(suggestion);
                }
                regionsController.clear();
              });
            },
          ),

          
          Wrap(
            spacing: 8,
            children: selectedRegions.map((skill) {
              return Chip(
                label: Text(skill),
                onDeleted: () {
                  setState(() {
                    selectedRegions.remove(skill);
                  });
                },
                deleteIcon: Icon(Icons.close),
              );
            }).toList(),
          ),
          SizedBox(height: 12),

        
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Choose an Image'),
          ),
          SizedBox(height: 12),
          if (_image != null) Image.file(_image!, height: 200, width: 200, fit: BoxFit.cover),



          Spacer(),
          ElevatedButton(
            onPressed: () async {
              try {
                int statusCode = await addPost();
                if (statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Post add successfully!')),
                  );
                  Navigator.pop(context);
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error adding post: $e')),
                );
                print('Error adding post: $e');
              }

            },
            child: Text('Post'),
          ),
        ],
      ),
    );
  }

// FIREBASE //////////////////////////////////

Future<void> _uploadImage(File image) async {
  try {
    String fileExtension = image.uri.path.split('.').last;

    String randomNumber = (Random().nextDouble()).toString();

    String title = titleController.text; 
    String firstName = 'Nation';
    String lastName = 'Builder';
    String region = selectedRegions.first;

    String fileName = 'job_picture_${title}_${firstName}_${lastName}_${randomNumber}.${fileExtension}';
    print(fileName);

    TaskSnapshot snapshot = await _firebaseStorage.ref('$region/$fileName').putFile(image);
    
    // Retrieve the URL of the uploaded image
    String downloadUrl = await snapshot.ref.getDownloadURL();
    
    setState(() {
      _uploadedImageUrl = downloadUrl;
    });
    
  } catch (e) {
    print("Error uploading image: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error uploading image: $e')),
    );
  }
}


  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _uploadImage(_image!);  
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No image selected')),
        );
      }
    });
  }


Future<int> addPost() async {
  Map<String, String> userData = await UserPreferences().getUserData();
  String firstNameOwner = userData['first_name']!;
  String lastNameOwner = userData['last_name']!;

  Map<String, dynamic> jobMap = {
    'title': titleController.text,
    'description': descriptionController.text,
    'picture': {
      'picture_location_firebase': _uploadedImageUrl, 
      'description': 'Uploaded image for post',  
    },
    'location': locationController.text,
    'labels': selectedSkills.map((skill) => {'label_name': skill}).toList(),
    'region': {
      'region_name': selectedRegions.first, 
      'country': 'Belgium'
    },
    'first_name_owner': firstNameOwner,
    'last_name_owner':lastNameOwner,
  };

  final response = await http.post(
    Uri.parse(fullUrl('job')),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(jobMap),
  );

  Map<String, dynamic> jsonResponse = json.decode(response.body);

  print(jsonResponse);

  if (jsonResponse['code'] == 200) {
    return 200;
  } else {
    var errorMessage;
    if (jsonResponse['message'] is String) {
      errorMessage = jsonResponse['message'];
    } else if (jsonResponse['message'] is List) {
      errorMessage = (jsonResponse['message'] as List)
          .map((dict) => dict.toString())
          .join(', ');
    } else {
      errorMessage = "Unexpected error format from the backend.";
    }

    throw Exception('Failed to submit the post: $errorMessage');
  }
}


////////////////////////////////////////////////////////////////

Future<List<String>> fetchAllSkills() async {
  final Uri uri = Uri.parse(fullUrl('all_labels'));
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['code'] == 200) {
      List<dynamic> labelsData = jsonResponse['message'];
      return labelsData.map((data) => data['label_name'] as String).toList();
    } else {
      throw Exception('Unexpected response from the backend: ${jsonResponse['message']}');
    }
  } else {
    throw Exception('Failed to load skills from the backend');
  }
}

Future<List<String>> fetchAllRegions() async {
  final Uri uri = Uri.parse(fullUrl('all_regions'));
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['code'] == 200) {
      List<dynamic> labelsData = jsonResponse['message'];
      return labelsData.map((data) => data['region_name'] as String).toList();
    } else {
      throw Exception('Unexpected response from the backend: ${jsonResponse['message']}');
    }
  } else {
    throw Exception('Failed to load regions from the backend');
  }
}


  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    skillsController.dispose();
    regionsController.dispose();
    super.dispose();
  }
}







