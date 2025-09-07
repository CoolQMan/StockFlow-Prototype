import 'package:flutter/material.dart';

enum UserRole { owner, planner, associate, dropshipper, retailer }

class AppProvider with ChangeNotifier {
  UserRole? _selectedRole;
  bool _isLoggedIn = false;

  UserRole? get selectedRole => _selectedRole;
  bool get isLoggedIn => _isLoggedIn;

  void setRole(UserRole role) {
    _selectedRole = role;
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _selectedRole = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}
