import 'package:project/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.displayName,
    super.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      displayName: json['display_name'],
      photoUrl: json['photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
    };
  }

  // For Firebase implementation
  // factory UserModel.fromFirebaseUser(User user) {
  //   return UserModel(
  //     id: user.uid,
  //     email: user.email ?? '',
  //     displayName: user.displayName,
  //     photoUrl: user.photoURL,
  //   );
  // }
}
