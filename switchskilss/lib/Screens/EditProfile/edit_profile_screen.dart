import 'package:flutter/material.dart';
import '../../components/background.dart';
import '../../responsive.dart';
import 'components/autodropdown.dart';

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
  List<String> selectedSkills = [];
  final TextEditingController skillsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
    emailController = TextEditingController(text: widget.email);
    phoneNumberController = TextEditingController(text: widget.phoneNumber);
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

          AutocompleteDropDown(
            options: allSkills,
            labelText: "Select Skills",
            validator: (value) {
                if (allSkills.contains(value ?? '')) {
                    return null; 
                } else {
                    return 'Invalid Skill';
                }
            },

            onItemSelected: (selected) {
                // Optional callback to handle the selected item
                print("Selected Skill: $selected");
            },
        ),
        

          Spacer(),
          ElevatedButton(
            onPressed: () {
              // Handle save functionality here
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
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
