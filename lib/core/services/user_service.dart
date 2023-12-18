class UserInfoService {
  // Private constructor to prevent direct instantiation
  UserInfoService._();

  // Singleton instance
  static final UserInfoService _instance = UserInfoService._();

  // Factory constructor to provide access to the instance
  factory UserInfoService() {
    return _instance;
  }

  // User information
  String? _user;

  // Getters and setters for user information
  String? get currentUser => _user;

  void setCurrentUser(String user) {
    _user = user;
  }
}
