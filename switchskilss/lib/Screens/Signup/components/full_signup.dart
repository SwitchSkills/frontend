import 'package:flutter/material.dart';
import '../../../components/background.dart';
import '../../../responsive.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../components/bottom_nav_bar.dart';
import '../../../user_preferences.dart';


class FullSingupScreen extends StatelessWidget {
  final String email;
  final String password;
  

  const FullSingupScreen({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Your Profile'),
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: Responsive(
          desktop: DesktopFullSignupScreen(),
          mobile: MobileFullSignupScreen(
            email: email,
            password: password,
          ),
        ),
      ),
    );
  }
}

class DesktopFullSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [],
    );
  }
}

class MobileFullSignupScreen extends StatefulWidget {
  final String email;
  final String password;

  MobileFullSignupScreen({
    required this.email,
    required this.password,
  });

  @override
  _MobileFullSignupScreenState createState() => _MobileFullSignupScreenState();
}

class _MobileFullSignupScreenState extends State<MobileFullSignupScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  late TextEditingController locationController;
  List<String> selectedSkills = [];
  List<String> selectedRegions = [];
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController regionsController = TextEditingController();
  List<String> allSkills = [];
  List<String> allRegions = [];
  bool isPasswordObscured = true;
  final String backendUrl = 'https://ethereal-yen-394407.ew.r.appspot.com/';

  late FocusNode _firstNameFocus;
  late FocusNode _lastNameFocus;
  late FocusNode _locationFocus;
  late FocusNode _emailFocus;
  late FocusNode _phoneNumberFocus;
  late FocusNode _passwordFocus;
  late FocusNode _skillsFocus;
  late FocusNode _regionsFocus;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  

  @override
  void initState() {
  super.initState();

  _loadSkills();
  _loadRegions();
  firstNameController = TextEditingController();
  lastNameController = TextEditingController();
 
  phoneNumberController = TextEditingController();
  locationController = TextEditingController();
  emailController = TextEditingController(text: widget.email);
  passwordController = TextEditingController(text: widget.password);
  _firstNameFocus = FocusNode();
  _lastNameFocus = FocusNode();
  _locationFocus = FocusNode();
  _emailFocus = FocusNode();
  _phoneNumberFocus = FocusNode();
  _passwordFocus = FocusNode();
  _skillsFocus = FocusNode();
  _regionsFocus = FocusNode();
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
    child: SingleChildScrollView(
    child: Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: firstNameController,
            focusNode: _firstNameFocus,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_lastNameFocus);
            },
            decoration: InputDecoration(
              labelText: 'First Name',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextFormField(
            controller: lastNameController,
            focusNode: _lastNameFocus,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_locationFocus);
            },
            decoration: InputDecoration(
              labelText: 'Last Name',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextFormField(
            controller: locationController,
            focusNode: _locationFocus,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_emailFocus);
            },
            decoration: InputDecoration(
              labelText: 'Your Location',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextFormField(
            controller: emailController,
            focusNode: _emailFocus,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_phoneNumberFocus);
            },
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextFormField(
            controller: phoneNumberController,
            focusNode: _phoneNumberFocus,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocus);
            },
            decoration: InputDecoration(
              labelText: 'Phone Number',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextFormField(
            controller: passwordController,
            focusNode: _passwordFocus,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_skillsFocus);
            },
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
              focusNode: _skillsFocus,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_regionsFocus);
              },
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
              focusNode: _regionsFocus,
              onEditingComplete: () {
                _regionsFocus.unfocus();
              },
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
                  final userDetails = await loginUserAndFetchDetails(emailController.text, passwordController.text);

                  await UserPreferences().saveUserData(
                    userId: userDetails['user_id'],
                    firstName: userDetails['first_name'],
                    lastName: userDetails['last_name'],
                    emailAddress: userDetails['email_address'],
                    phoneNumber: userDetails['phone_number'],
                    alternativeCommunication: userDetails['alternative_communication'] ?? '',
                    bibliography: userDetails['bibliography'] ?? '',
                    location: userDetails['location'],
                    pictureLocationFirebase: userDetails['picture_location_firebase'] ?? '',
                    pictureDescription: userDetails['picture_description'] ?? '',
                    regions: jsonEncode(userDetails['regions']),
                    labels: jsonEncode(selectedSkills.map((skill) => {'label_name': skill}).toList()),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User info created successfully!')),
                  );

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar()));

                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error creating user info: $statusCode')),
                  );
                  print('Error updating user info: $statusCode');
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error creating user info: $e')),
                );
                print('Error updating user info: $e');
              }
            },
            child: Text('Complete'),
          ),

        ],
      ),
    ),
    ),
    );
  }

Future<Map<String, dynamic>> loginUserAndFetchDetails(String emailAddress, String password) async {
  Map<String, dynamic> loginData = {
    'type': 'email_address',
    'search': emailAddress,
    'password': password,
  };

  final response = await http.post(
    Uri.parse(fullUrl('login')),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(loginData),
  );

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    if (jsonResponse['code'] == 200) {
      return jsonResponse['message'][0];
    } else {
      throw Exception(jsonResponse['message']);
    }
  } else {
    throw Exception('Failed to login and fetch user details.');
  }
}



Future<int> updateUserInfo() async {
  ;
  Map<String, dynamic> userMap = {
    'first_name': firstNameController.text,
    'last_name': lastNameController.text,
    'location': locationController.text,
    'email_address': emailController.text,
    'phone_number': phoneNumberController.text,
    'password': passwordController.text,
    'labels': selectedSkills.map((skill) => {'label_name': skill}).toList(),
    'regions': selectedRegions.map((region) => {'region_name': region, 'country': 'Belgium'}).toList(),
  };

  final response = await http.post(
    Uri.parse(fullUrl('user')),
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
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    locationController.dispose();
    regionsController.dispose();
    passwordController.dispose();
    skillsController.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _locationFocus.dispose();
    _emailFocus.dispose();
    _phoneNumberFocus.dispose();
    _passwordFocus.dispose();
    _skillsFocus.dispose();
    _regionsFocus.dispose();
    super.dispose();
  }
}








