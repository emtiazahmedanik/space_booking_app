class Urls {
  static const String baseUrl =
      'https://pastor-lili-backend-server.onrender.com';

  static const String login = '$baseUrl/auth/login';
  static const String signUp = '$baseUrl/auth/signup';
  static const String getProfile = '$baseUrl/users/me';
  static const String getSpaces = '$baseUrl/spaces';
  static const String bookings = '$baseUrl/bookings';
  static const String getBookings = '$baseUrl/bookings/my-bookings';
  static const String googleAuth = '$baseUrl/auth/google';
}
