import 'package:flutter/material.dart';
import '../../EditProfile/edit_profile_screen.dart';

class ProfileInformation extends StatelessWidget {
  final String profilePictureUrl;
  final String firstName;
  final String lastName;
  final List<String> skills;
  final List<String> regions;
  final String email;
  final String telephone;

  ProfileInformation({
    required this.profilePictureUrl,
    required this.firstName,
    required this.lastName,
    required this.skills,
    required this.regions,
    required this.email,
    required this.telephone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(profilePictureUrl),
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: Text("$firstName $lastName",
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange)),
                ),
                SizedBox(height: 10),
                Text("Skills: ${skills.join(", ")}", style: TextStyle(color: Colors.black)),
                SizedBox(height: 10),
                Text("Active Regions: ${regions.join(", ")}", style: TextStyle(color: Colors.black)),
                Divider(color: Colors.orange),
                Text("Email: $email", style: TextStyle(color: Colors.black)),
                SizedBox(height: 5),
                Text("Phone: $telephone", style: TextStyle(color: Colors.black)),
                SizedBox(height: 5),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                            firstName: '$firstName',
                            lastName: '$lastName',
                            email: '$email',
                            phoneNumber: '$telephone',
                          ),
                        ),
                      );
                    },
                    child: Icon(Icons.edit, size: 16, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      minimumSize: Size(32, 32),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
