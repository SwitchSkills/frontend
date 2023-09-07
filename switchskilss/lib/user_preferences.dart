import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  Future<void> saveUserData({
    required String firstName,
    required String lastName,
    required String location,
    required String emailAddress,
    required String phoneNumber,
    required String password,
    required String skills,
    required String regions,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('first_name', firstName);
    prefs.setString('last_name', lastName);
    prefs.setString('location', location);
    prefs.setString('email_address', emailAddress);
    prefs.setString('phone_number', phoneNumber);
    prefs.setString('password', password);
    prefs.setString('labels', skills);
    prefs.setString('regions', regions);
  }

  Future<Map<String, String>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return {
      'first_name': prefs.getString('first_name') ?? 'Default First Name',
      'last_name': prefs.getString('last_name') ?? 'Default Last Name',
      'location': prefs.getString('location') ?? 'Default Location',
      'email_address': prefs.getString('email_address') ?? 'Default Email Address',
      'phone_number': prefs.getString('phone_number') ?? 'Default Phone Number',
      'password': prefs.getString('password') ?? 'Default Password',
      'labels': prefs.getString('labels') ?? '',
      'regions': prefs.getString('regions') ?? '',
    };
  }

  Future<void> removeUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('first_name');
    prefs.remove('last_name');
    prefs.remove('location');
    prefs.remove('email_address');
    prefs.remove('phone_number');
    prefs.remove('password');
    prefs.remove('labels');
    prefs.remove('regions');
  }
}
