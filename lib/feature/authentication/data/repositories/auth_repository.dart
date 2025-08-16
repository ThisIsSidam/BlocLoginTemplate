import 'package:blocloginexample/core/exceptions/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  AuthRepository({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;
  final Map<String, User> _cachedUsers = {};

  static const _userCacheKey = '__user_cache_key__';

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) {
        _cachedUsers.remove(_userCacheKey);
        return null;
      }
      _cachedUsers[_userCacheKey] = user;
      return user;
    });
  }

  User? get currentUser => _cachedUsers[_userCacheKey];

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (_) {
      throw SignUpWithEmailAndPasswordFailure(
          "Failed to Sign up! Check email and password.");
    } catch (e) {
      throw SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (_) {
      throw SignUpWithEmailAndPasswordFailure(
          "Failed to Login! Check email and password.");
    } catch (e) {
      throw SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw LogoutFailure();
    }
  }
}
