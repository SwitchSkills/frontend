import 'package:flutter/material.dart';
import '../../components/background.dart';
import '../../responsive.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


final List<String> allSkills = ['Java', 'Python', 'Flutter', 'Dart', 'JavaScript', 'React', 'Angular', 'Vue'];

class EditProfileScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  const EditProfileScreen({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: Responsive(
          desktop: DesktopEditProfileScreen(),
          mobile: MobileEditProfileScreen(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phoneNumber: phoneNumber,
          ),
        ),
      ),
    );
  }
}

class DesktopEditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [],
    );
  }
}

class MobileEditProfileScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  MobileEditProfileScreen({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });

  @override
  _MobileEditProfileScreenState createState() => _MobileEditProfileScreenState();
}

class _MobileEditProfileScreenState extends State<MobileEditProfileScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  List<String> selectedSkills = [];
  List<String> selectedRegions = [];
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController regionsController = TextEditingController();
  final List<String> allSkills = ['Java', 'Flutter', 'Python', 'C++', 'Dart', 'React', 'Node.js']; 
  final List<String> allRegions = ['Limburg', 'Antwerpen', 'West-Vlaanderen'];
  bool isPasswordObscured = true;


  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
    emailController = TextEditingController(text: widget.email);
    phoneNumberController = TextEditingController(text: widget.phoneNumber);
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextField(
            controller: firstNameController,
            decoration: InputDecoration(
              labelText: 'First Name',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: lastNameController,
            decoration: InputDecoration(
              labelText: 'Last Name',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: phoneNumberController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordObscured ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordObscured = !isPasswordObscured;
                  });
                },
              ),
            ),
            obscureText: isPasswordObscured,
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
          

          
        

          Spacer(),
          ElevatedButton(
            onPressed: () async {
              try {
                int statusCode = await updateUserInfo();
                if (statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User info updated successfully!')),
                  );
                  print(statusCode);
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error updating user info: $e')),
                );
                print('Error updating user info: $e');
              }
            },
            child: Text('Save'),
          ),

          

        ],
      ),
    );
  }
Future<int> updateUserInfo() async {
  final String backendUrl = 'https://ethereal-yen-394407.ew.r.appspot.com/user';
  
  Map<String, dynamic> userMap = {
    'first_name': firstNameController.text,
    'last_name': lastNameController.text,
    'email_address': emailController.text,
    'phone_number': phoneNumberController.text,
    'password': passwordController.text,
    'labels': selectedSkills.map((skill) => {'label_name': skill}).toList(),
    'regions': selectedRegions.map((region) => {'region_name': region, 'country': 'YOUR_COUNTRY_NAME'}).toList(),
  };

  final response = await http.post(
    Uri.parse(backendUrl),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(userMap),
  );

  Map<String, dynamic> jsonResponse = json.decode(response.body);

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

    throw Exception('Failed to update user info: $errorMessage');
  }
}


  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    skillsController.dispose();
    super.dispose();
  }
}








