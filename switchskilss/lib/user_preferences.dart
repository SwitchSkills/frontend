import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  Future<void> setLikedJobs(List<String> likedJobs) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('likedJobs', likedJobs);
  }

  Future<List<String>> getLikedJobs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('likedJobs') ?? [];
  }

  Future<void> saveUserData({
    required String userId,
    required String firstName,
    required String lastName,
    required String emailAddress,
    required String phoneNumber,
    required String location,
    required String alternativeCommunication,
    required String bibliography,
    required String pictureLocationFirebase,
    required String pictureDescription,
    required String regions,
    required String labels,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('user_id', userId);
    prefs.setString('first_name', firstName);
    prefs.setString('last_name', lastName);
    prefs.setString('email_address', emailAddress);
    prefs.setString('phone_number', phoneNumber);
    prefs.setString('location', location);
    prefs.setString('alternative_communication', alternativeCommunication);
    prefs.setString('bibliography', bibliography);
    prefs.setString('picture_location_firebase', pictureLocationFirebase);
    prefs.setString('picture_description', pictureDescription);
    prefs.setString('regions', regions);
    prefs.setString('labels', labels);
  }

  Future<Map<String, String>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return {
      'user_id': prefs.getString('user_id') ?? 'Default User Id',
      'first_name': prefs.getString('first_name') ?? 'Default First Name',
      'last_name': prefs.getString('last_name') ?? 'Default Last Name',
      'email_address': prefs.getString('email_address') ?? 'Default Email Address',
      'phone_number': prefs.getString('phone_number') ?? 'Default Phone Number',
      'location': prefs.getString('location') ?? 'Default Location',
      'alternative_communication': prefs.getString('alternative_communication') ?? 'Default Alternative Communication',
      'bibliography': prefs.getString('bibliography') ?? 'Default Bibliography',
      'picture_location_firebase': prefs.getString('picture_location_firebase') ?? 'Default Picture Location Firebase',
      'picture_description': prefs.getString('picture_description') ?? 'Default Picture Description',
      'regions': prefs.getString('regions') ?? '', 
      'labels' : prefs.getString('labels') ?? '',
    };
  }

  Future<void> removeUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('user_id');
    prefs.remove('first_name');
    prefs.remove('last_name');
    prefs.remove('email_address');
    prefs.remove('phone_number');
    prefs.remove('location');
    prefs.remove('alternative_communication');
    prefs.remove('bibliography');
    prefs.remove('picture_location_firebase');
    prefs.remove('picture_description');
    prefs.remove('regions');
    prefs.remove('labels');
}

}
