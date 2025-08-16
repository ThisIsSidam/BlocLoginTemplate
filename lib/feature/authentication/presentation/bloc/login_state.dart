import 'package:blocloginexample/feature/authentication/data/models/form_inputs.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class LoginState extends Equatable {
  const LoginState() : this._();

  const LoginState._({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  LoginState withEmail(String email) => LoginState._(
        email: Email.dirty(email),
        password: password,
      );

  LoginState withPassword(String password) => LoginState._(
        email: email,
        password: Password.dirty(password),
      );

  LoginState withSubmissionInProgress() => LoginState._(
        email: email,
        password: password,
        status: FormzSubmissionStatus.inProgress,
      );

  LoginState withSubmissionSuccess() => LoginState._(
        email: email,
        password: password,
        status: FormzSubmissionStatus.success,
      );

  LoginState withSubmissionFailure([String? errorMessage]) => LoginState._(
        email: email,
        password: password,
        status: FormzSubmissionStatus.failure,
        errorMessage: errorMessage,
      );

  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  bool get isValid => Formz.validate([email, password]);

  @override
  List<Object?> get props => [email, password, status, errorMessage];
}
