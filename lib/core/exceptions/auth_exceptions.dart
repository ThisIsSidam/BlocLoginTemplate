class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure(
      [this.message = "Something went wrong!"]);

  final String message;
}

class LoginWithEmailAndPasswordFailure implements Exception {
  const LoginWithEmailAndPasswordFailure(
      [this.message = "Something went wrong!"]);

  final String message;
}

class LogoutFailure implements Exception {}
