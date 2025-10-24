import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:pastor_lili/core/services/end_points.dart';
import 'package:pastor_lili/core/services/storage_service.dart';
import 'package:pastor_lili/routes/app_routes.dart';

class GoogleSignInService {
  // Singleton instance
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  // Stream subscription for authentication events
  StreamSubscription<GoogleSignInAuthenticationEvent>? _authSubscription;

  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false;

  GoogleSignInService() {
    _initialize();
  }

  /// Initialize Google Sign-In
  Future<void> _initialize() async {
    await _googleSignIn.initialize(
      clientId: null, // optional for mobile
      serverClientId:
          '568199341849-1cu4ts7gg5vh2dfklficbb6a3qvve25s.apps.googleusercontent.com', // optional unless you need backend auth
    );

    // Listen for authentication changes
    _authSubscription = _googleSignIn.authenticationEvents.listen(
      _handleAuthEvent,
      onError: _handleAuthError,
    );

    // Try lightweight authentication (auto sign-in)
    await _googleSignIn.attemptLightweightAuthentication();
  }

  Future<void> _handleAuthEvent(GoogleSignInAuthenticationEvent event) async {
    GoogleSignInAccount? user;
    switch (event) {
      case GoogleSignInAuthenticationEventSignIn():
        user = event.user;
        break;
      case GoogleSignInAuthenticationEventSignOut():
        user = null;
        break;
    }

    final GoogleSignInClientAuthorization? authorization = await user
        ?.authorizationClient
        .authorizationForScopes([
          'email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ]);

    _currentUser = user;
    _isAuthorized = authorization != null;

    if (_currentUser != null) {
      final bool isSuccess = await postGoogleAuth();
      if (isSuccess) {
        Get.offAllNamed(AppRoute.bottomNavbarView);
      }
      //EasyLoading.showSuccess("✅ Signed in:(${_currentUser!.email})",);
      if (kDebugMode) {
        
        print(
          "✅ Signed in: ${_currentUser!.displayName} (${_currentUser!.email}) (${_currentUser!.photoUrl} )",
        );
      }
    } else {
      if (kDebugMode) {
        print("🚪 Signed out");
      }
    }
  }

  void _handleAuthError(Object error) {
    if (kDebugMode) {
      EasyLoading.showError("Google Sign-In error");
      print("❌ Google Sign-In error: $error");
    }
    _currentUser = null;
    _isAuthorized = false;
  }

  Future<void> signIn() async {
    try {
      await _googleSignIn.authenticate();
    } on GoogleSignInException catch (e) {
      if (kDebugMode) {
        EasyLoading.showError(" Sign-in canceled or failed");
        print("⚠️ Sign-in canceled or failed: ${e.code}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Unknown sign-in error: $e");
      }
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    _currentUser = null;
    _isAuthorized = false;
  }

  /// Current signed-in user
  GoogleSignInAccount? get currentUser => _currentUser;

  /// Whether user is authorized for required scopes
  bool get isAuthorized => _isAuthorized;

  /// Dispose the stream subscription
  void dispose() {
    _authSubscription?.cancel();
  }

  Future<bool> postGoogleAuth() async {
    try {
      final Map<String, dynamic> body = {
        "fullName": _currentUser?.displayName,
        "email": _currentUser?.email,
        "avatar": _currentUser?.photoUrl,
      };

      final http.Response response = await http.post(
        Uri.parse(Urls.googleAuth),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final responseBody = jsonDecode(response.body);
      debugPrint('========response is: $responseBody');

      if (response.statusCode == 201 ||
          response.statusCode == 200 && responseBody['status'] == 'success') {
        final String token = responseBody['data']['accessToken'];
        final String userId = responseBody['data']['user']['id'];
        debugPrint('========Token is: $token');
        debugPrint('========Id is: $userId');
        await StorageService.saveToken(token, '');
        await StorageService.saveUserId(userId);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Error is : $e");
      return false;
    }
  }
}
