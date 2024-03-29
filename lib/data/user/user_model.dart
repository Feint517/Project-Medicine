import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_med/utils/formatters/formatters.dart';

class UserModel {
  //? final variables are the ones that should not be modified
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  final String password;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    this.password = '',
    required this.phoneNumber,
    required this.profilePicture,
  });

  //* helper function to get the full name
  String get fullName => '$firstName $lastName';

  //* helper function to format phone number
  String get formattedPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

  //* static function to split full name into first name and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

  //* static function to generate a username from the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String cameCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$cameCaseUsername"; //? add cwt_ prefix
    return usernameWithPrefix;
  }

  //* static function to create an empty user model
  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        username: '',
        email: '',
        phoneNumber: '',
        password: '',
        profilePicture: '',
      );

  //* convert model to JSON structure to store data in firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Password': password,
      'ProfilePicture': profilePicture,
    };
  }

  //* factory method to create a UserModel from a firebase document snapshot (recieve values)
  //? factory class allows us to create multiple constructors for the same class
  //? fromSnapshot is the name of the constructor
  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        password: data['Password'],
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
