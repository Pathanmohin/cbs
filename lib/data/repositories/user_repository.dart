// lib/data/repositories/user_repository.dart
import '../../domain/entities/user_profile.dart';

class UserRepository {
  Future<UserProfile> getUserProfile() async {
    // Call API or database to fetch user profile
    return UserProfile(name: "John Doe", profileImageUrl: "https://via.placeholder.com/150");
  }
}
