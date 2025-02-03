import 'package:flutter/material.dart';

class BankingOption {
  final String label;
  final IconData icon;
  final VoidCallback onTap; // Callback function

  BankingOption({
    required this.label,
    required this.icon,
    required this.onTap,
  });
}
