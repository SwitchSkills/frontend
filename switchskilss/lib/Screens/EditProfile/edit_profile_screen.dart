import 'package:flutter/material.dart';
import '../../components/background.dart';
import '../../responsive.dart';

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
      children: [
      ],
    );
  }
}

class MobileEditProfileScreen extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;

  MobileEditProfileScreen({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
  })  : firstNameController = TextEditingController(text: firstName),
        lastNameController = TextEditingController(text: lastName),
        emailController = TextEditingController(text: email),
        phoneNumberController = TextEditingController(text: phoneNumber);

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


          Spacer(),
          ElevatedButton(
            onPressed: () {
              // Handle save functionality here
              // For example, you can print out the edited fields:
              print('First Name: ${firstNameController.text}');
              print('Last Name: ${lastNameController.text}');
              print('Email: ${emailController.text}');
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
