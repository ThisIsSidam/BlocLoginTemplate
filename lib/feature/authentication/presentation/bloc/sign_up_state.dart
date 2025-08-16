import 'package:blocloginexample/feature/authentication/data/models/form_inputs.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class SignUpState extends Equatable {
  const SignUpState() : this._();

  const SignUpState._({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  SignUpState withEmail(String email) => SignUpState._(
      email: Email.dirty(email),
      password: password,
      confirmedPassword: confirmedPassword);

  SignUpState withPassword(String password) => SignUpState._(
      email: email,
      password: Password.dirty(password),
      confirmedPassword: ConfirmedPassword.dirty(
          password: password, value: confirmedPassword.value));

  SignUpState withConfirmedPassword(String confirmedPwd) => SignUpState._(
      email: email,
      password: password,
      confirmedPassword: ConfirmedPassword.dirty(
          password: password.value, value: confirmedPwd));

  SignUpState withSubmissionInProgress() => SignUpState._(
        email: email,
        password: password,
        confirmedPassword: confirmedPassword,
        status: FormzSubmissionStatus.inProgress,
      );

  SignUpState withSubmissionSuccess() => SignUpState._(
        email: email,
        password: password,
        confirmedPassword: confirmedPassword,
        status: FormzSubmissionStatus.success,
      );

  SignUpState withSubmissionFailure([String? errorMessage]) => SignUpState._(
        email: email,
        password: password,
        confirmedPassword: confirmedPassword,
        status: FormzSubmissionStatus.failure,
        errorMessage: errorMessage,
      );

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  bool get isValid => Formz.validate([email, password, confirmedPassword]);

  @override
  List<Object?> get props =>
      [email, password, confirmedPassword, status, errorMessage];
}
