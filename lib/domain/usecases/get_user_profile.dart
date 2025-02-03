// lib/domain/usecases/get_user_profile.dart
import '../entities/user_profile.dart';

class GetUserProfile {

  Future<UserProfile> execute() async {
    // Fetch user profile data from repository
    return UserProfile(name: "John Doe", profileImageUrl: "https://via.placeholder.com/150");
  }

}
