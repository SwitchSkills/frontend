import 'package:flutter/material.dart';
import '../../responsive.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../user_preferences.dart';

enum SearchType {
  description,
  name,
  skill,
  skillDescription,
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
  final TextEditingController searchController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final String backendUrl = 'https://ethereal-yen-394407.ew.r.appspot.com/';
  SearchType? selectedSearchType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
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
      case SearchType.name:
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
      case SearchType.skillDescription:
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

  switch (selectedSearchType) {
    case SearchType.description:
      payload['search'] = 'description';
      payload['description'] = searchController.text;
      break;

    case SearchType.name:
      payload['first_name'] = firstNameController.text;
      payload['last_name'] = lastNameController.text;
      break;

    case SearchType.skill:
      payload['search'] = 'skill';
      payload['skill'] = searchController.text;
      break;

    case SearchType.skillDescription:
      payload['search'] = 'skill description';
      payload['skill description'] = searchController.text;
      break;

    case SearchType.title:
      payload['search'] = 'title';
      payload['title'] = searchController.text;
      break;

    default:
      _showFeedback('Invalid search type');
      return;
  }

  try {
    final response = await http.post(
      Uri.parse(backendUrl + 'search_job'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.isEmpty) {
        _showFeedback('No results found.');
      } else {
        // Handle your data here, for example, update the UI or navigate to another screen
      }
    } else {
      _showFeedback('Failed to search: ${response.body}');
    }
  } catch (error) {
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
