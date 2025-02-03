// lib/presentation/viewmodels/drawer_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:hpscb/domain/usecases/get_user_profile.dart';
import 'package:hpscb/domain/usecases/logout.dart';


class DrawerViewModel extends ChangeNotifier {
  final GetUserProfile getUserProfile;
  final Logout logout;

  String _userName = "Guest";
  String _userProfileImage = "https://via.placeholder.com/150";

  String get userName => _userName;
  String get userProfileImage => _userProfileImage;

  DrawerViewModel({
    required this.getUserProfile,
    required this.logout,
  }) {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userProfile = await getUserProfile.execute();
    _userName = userProfile.name;
    _userProfileImage = userProfile.profileImageUrl;
    notifyListeners();
  }

  void onHomeSelected() {
    // Navigate to home screen or do something
  }

  void onSettingsSelected() {
    // Navigate to settings or do something
  }

  void onLogout() {
    logout.execute();
  }
}
