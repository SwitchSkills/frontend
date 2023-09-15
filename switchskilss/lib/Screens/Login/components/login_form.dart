import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import '../../../components/bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../user_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}
class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String backendUrl = 'https://ethereal-yen-394407.ew.r.appspot.com/';

  String firstName = ''; 
  String lastName = ''; 
  String password = '';

  bool isPasswordObscured = true;


  String fullUrl(String route) {
    return backendUrl + route;
  }

  Future<void> _loginUser(BuildContext context) async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      var response;
      try {
        response = await http.post(
          Uri.parse(fullUrl('login')),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'type': 'full_name',
            'first_name': firstName,
            'last_name': lastName,
            'password': password,
          }),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Network error. Please try again.')),
        );
        return;
      }

      final responseData = json.decode(response.body);

      if (responseData['code'] != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
      } else {
        if (responseData['message'] is List && responseData['message'].isNotEmpty) {
          var user = responseData['message'][0];
          
          UserPreferences().saveUserData(
            userId: user['user_id'],
            firstName: user['first_name'],
            lastName: user['last_name'],
            emailAddress: user['email_address'],
            phoneNumber: user['phone_number'],
            location: user['location'],
            password: user['password'],
            alternativeCommunication: user['alternative_communication'],
            bibliography: user['bibliography'],
            pictureLocationFirebase: user['picture_location_firebase'],
            pictureDescription: user['picture_description'],
            regions: jsonEncode(user['regions']),
            labels: 'nog geen label'
        );
        void printUserData() async {
          final Map<String, String> userData = await UserPreferences().getUserData();
          print('User Data: $userData');
        }
        printUserData();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Welcome Back ' + responseData['message'][0]['first_name'] + ' ' + responseData['message'][0]['last_name'])),
        );
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavBar()));
        } else {
            print('Unexpected data format from the backend or empty data');
            print(responseData);
            print(responseData['message']);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Unexpected data format or empty data from the backend')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: Colors.white,
            onSaved: (firstname) {
              firstName = firstname ?? '';
            },
            decoration: InputDecoration(
              hintText: "Your first name",
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: Colors.white,
            onSaved: (lastname) {
              lastName = lastname ?? '';
            },
            decoration: InputDecoration(
              hintText: "Your last name",
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(
                  Icons.people,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: isPasswordObscured,
              cursorColor: Colors.white,
              onSaved: (value) {
                password = value ?? '';
              },
              decoration: InputDecoration(
                hintText: "Your password",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordObscured ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordObscured = !isPasswordObscured;
                    });
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () => _loginUser(context),
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
