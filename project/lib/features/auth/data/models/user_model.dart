import 'package:project/features/auth/domain/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  factory UserModel.fromSupabaseUser(User user) {
    final metadata = user.userMetadata ?? <String, dynamic>{};
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      displayName: metadata['full_name'] as String? ?? user.email,
      photoUrl: metadata['avatar_url'] as String?,
    );
  }
}
