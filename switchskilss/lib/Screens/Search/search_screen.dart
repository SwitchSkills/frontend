import 'package:flutter/material.dart';
import '../../responsive.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../user_preferences.dart';

enum SearchType {
  description,
  owner,
  skill,
  title,
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Responsive(
          desktop: DesktopSearchScreen(),
          mobile: MobileSearchScreen(),
        ),
      ),
    );
  }
}

class DesktopSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [],
    );
  }
}

class MobileSearchScreen extends StatefulWidget {
  @override
  _MobileSearchScreenState createState() => _MobileSearchScreenState();
}

class _MobileSearchScreenState extends State<MobileSearchScreen> {
  late TextEditingController searchController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  List<String> selectedRegions = [];
  String? selectedSkill;

  List<String> allSkills = [];
  List<String> allRegions = [];

  final TextEditingController skillsController = TextEditingController();
  final TextEditingController regionsController = TextEditingController();
  

  final String backendUrl = 'https://ethereal-yen-394407.ew.r.appspot.com/';
  SearchType? selectedSearchType;

  @override
  void initState() {
    super.initState();

    _loadSkills();
    _loadRegions();

    searchController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();


  }

  String fullUrl(String route) {
    return backendUrl + route;
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [

          Container(
            padding: EdgeInsets.all(8),  
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Text(
                "Search Jobs",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,  
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

          DropdownButton<SearchType>(
            hint: Text('Select search type'),
            value: selectedSearchType,
            items: SearchType.values.map((type) {
              return DropdownMenuItem(
                child: Text(type.toString().split('.').last),
                value: type,
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedSearchType = value;
              });
            },
          ),
          SizedBox(height: 12),
          ..._buildSearchFields(),
          SizedBox(height: 12),
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
            onPressed: _performSearch,
            child: Text('Search'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSearchFields() {
    switch (selectedSearchType) {
      case SearchType.description:
        return [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
        ];
      case SearchType.owner:
        return [
          TextField(
            controller: firstNameController,
            decoration: InputDecoration(
              labelText: 'First Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: lastNameController,
            decoration: InputDecoration(
              labelText: 'Last Name',
              border: OutlineInputBorder(),
            ),
          ),
        ];
      case SearchType.skill:
      return [
        TypeAheadFormField<String>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: skillsController,
              decoration: InputDecoration(
                labelText: 'Search for a skill',
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
                selectedSkill = suggestion; 
                skillsController.clear();
              });
            },
          ),

          
          if (selectedSkill != null)
            Chip(
              label: Text(selectedSkill!),
              onDeleted: () {
                setState(() {
                  selectedSkill = null;  
                });
              },
              deleteIcon: Icon(Icons.close),
            ),
          SizedBox(height: 12),

      ];
      case SearchType.title:
        return [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: selectedSearchType.toString().split('.').last,
              border: OutlineInputBorder(),
            ),
          ),
        ];
      default:
        return [];
    }
  }

  void _performSearch() async {
    Map<String, dynamic> payload = {};
    List<Map<String, dynamic>> regionPayload = [];

    for (String region in selectedRegions) {
      regionPayload.add({
        'country': 'Belgium',
        'region_name': region
      });
    }

    payload['region'] = regionPayload;

    switch (selectedSearchType) {
      case SearchType.description:
        payload['type'] = 'description';
        payload['search'] = searchController.text;
        break;

      case SearchType.owner:
        payload['type'] = 'owner';
        if (firstNameController.text.isNotEmpty) {
          payload['first_name'] = firstNameController.text;
        }
        if (lastNameController.text.isNotEmpty) {
          payload['last_name'] = lastNameController.text;
        }
        break;

      case SearchType.skill:
        payload['type'] = 'skills';
        payload['search'] = selectedSkill; 
        break;

      case SearchType.title:
        payload['type'] = 'title';
        payload['search'] = searchController.text;
        break;

      default:
        _showFeedback('Invalid search type');
        return;
    }
  print(payload);

  try {
    final response = await http.post(
      Uri.parse('https://ethereal-yen-394407.ew.r.appspot.com/search_jobs'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(payload),
    );

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    print(jsonResponse);
    
    int statusCode = jsonResponse['code'];
    String message = jsonResponse['message'];

    print(message);
    print(statusCode);
    
   

    if (statusCode == 200) {
      if (response.headers['content-type']?.contains('application/json') ?? false) {
        
        if (message is List) {
          print(message);
        } else {
          _showFeedback('Unexpected JSON structure.');
        }
      } else {
        _showFeedback('Expected JSON response, but got something else.');
      }
    } else {
      _showFeedback('Failed to search: ${response.body}');
    }
  } catch (error) {
    print(error);
    _showFeedback('Error performing search: $error');
  }


}



void _showFeedback(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}


  @override
  void dispose() {
    searchController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }
}
