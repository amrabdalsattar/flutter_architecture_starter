import '../enums/gender.dart';
import '../utils/app_assets.dart';

class UserModel extends SubUserModel {
  final String token;

  const UserModel(
    super._profilePictureFilePath, {
    required super.fullName,
    required super.gender,
    required super.email,
    required this.token,
    required super.phoneNumber,
    required super.id,
    required super.role,
    required super.summary,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final subModel = SubUserModel.fromJson(json);

    return UserModel(
      token: json['token'],
      id: subModel.id,
      fullName: subModel.fullName,
      email: subModel.email,
      gender: subModel.gender,
      phoneNumber: subModel.phoneNumber,
      role: subModel.role,
      subModel._profilePictureFilePath,
      summary: subModel.summary,
    );
  }

  UserModel copyWith({String? role}) {
    return UserModel(
      id: id,
      email: email,
      token: token,
      gender: gender,
      summary: summary,
      fullName: fullName,
      role: role ?? this.role,
      _profilePictureFilePath,
      phoneNumber: phoneNumber,
    );
  }
}

class SubUserModel {
  final String id;
  final String fullName;
  final Gender gender;
  final String email;
  final String? phoneNumber;
  final String? _profilePictureFilePath;
  final String role;
  final String? summary;

  const SubUserModel(
    this._profilePictureFilePath, {
    required this.phoneNumber,
    required this.id,

    required this.fullName,
    required this.gender,
    required this.email,
    required this.role,
    required this.summary,
  });

  String get profilePicture {
    if (_profilePictureFilePath == null || _profilePictureFilePath.isEmpty) {
      return AppAssets.placeHolder;
    }

    return _profilePictureFilePath;
  }

  Map<String, dynamic> toJson() {
    return {
      'user': {
        'id': id,
        'email': email,
        'summary': summary,
        'fullName': fullName,
        'gender': gender.name,
        'phoneNumber': phoneNumber,
        'profilePicture': _profilePictureFilePath,
      },
      'role': role,
    };
  }

  factory SubUserModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];
    return SubUserModel(
      id: userJson['id'],
      phoneNumber: userJson['phoneNumber'],
      fullName: userJson['fullName'] as String? ?? '',
      gender: Gender.values.firstWhere(
        (g) => g.name == userJson['gender'].toString().toLowerCase(),
        orElse: () => Gender.male,
      ),
      email: userJson['email'] as String? ?? '',
      userJson['profilePicture'],
      role: json['role'],
      summary: userJson['summary'],
    );
  }

  factory SubUserModel.guest() => const SubUserModel(
    AppAssets.placeHolder,
    phoneNumber: '',
    id: '',

    fullName: '',
    gender: Gender.male,
    email: '',
    role: 'guest',
    summary: null,
  );

  bool get isGuest => role.toLowerCase() == 'guest';
}
