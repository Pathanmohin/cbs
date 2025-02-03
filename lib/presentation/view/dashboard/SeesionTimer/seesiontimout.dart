import 'dart:async';
import 'package:flutter/material.dart';

class SessionTimeoutManager {
  Timer? _sessionTimer;
  final int _timeoutDuration; // Timeout duration in minutes
  final VoidCallback onSessionTimeout;

  SessionTimeoutManager({
    required int timeoutDuration,
    required this.onSessionTimeout,
  }) : _timeoutDuration = timeoutDuration;

  /// Starts the session timeout timer.
  void startTimer() {
    _cancelTimer(); // Ensure no duplicate timers are running
    _sessionTimer = Timer(
      Duration(minutes: _timeoutDuration),
      onSessionTimeout,
    );
  }

  /// Resets the session timeout timer.
  void resetTimer() {
    startTimer();
  }

  /// Cancels the current timer if it exists.
  void _cancelTimer() {
    if (_sessionTimer?.isActive ?? false) {
      _sessionTimer?.cancel();
    }
  }

  /// Disposes the timer to free up resources.
  void dispose() {
    _cancelTimer();
  }
}
