import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import '../../Signup/components/full_signup.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;

  @override
  void initState() {
    super.initState();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ), 
      child: SingleChildScrollView(
      child: Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            focusNode: _emailFocus,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocus);
            },
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: Colors.white,
            onSaved: (value) => email = value ?? '',   

            decoration: InputDecoration(
              hintText: "Your email",
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: Colors.white,
              focusNode: _passwordFocus,
                  onFieldSubmitted: (_) {
                    _passwordFocus.unfocus();
                  },
              onSaved: (value) => password = value ?? '',
              decoration: InputDecoration(
                hintText: "Your password",
                hintStyle: TextStyle(
                color: Colors.white,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(
                    Icons.lock,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState != null) {
                _formKey.currentState!.save();
              }

              Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullSingupScreen(
                            email: '$email',
                            password: '$password',
                          ),
                        ),
                      );

            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    ),
      ),
    );
  }
}