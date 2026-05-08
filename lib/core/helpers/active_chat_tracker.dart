/// A simple tracker to keep track of the currently active chat session.
/// Used to prevent showing notifications for the chat the user is currently viewing.
class ActiveChatTracker {
  ActiveChatTracker._();

  static String? _currentSessionId;
  static String? get currentSessionId => _currentSessionId;

  static void setActiveSession(String sessionId) =>
      _currentSessionId = sessionId;

  static void clearActiveSession() => _currentSessionId = null;

  /// Checks if the given session ID is the currently active chat.
  static bool isActiveSession(String? sessionId) {
    if (sessionId == null || _currentSessionId == null) return false;
    return _currentSessionId == sessionId;
  }
}
