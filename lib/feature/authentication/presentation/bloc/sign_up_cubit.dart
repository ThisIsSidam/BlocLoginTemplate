import 'package:blocloginexample/core/exceptions/auth_exceptions.dart';
import 'package:blocloginexample/feature/authentication/data/repositories/auth_repository.dart';
import 'package:blocloginexample/feature/authentication/presentation/bloc/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authRepo) : super(const SignUpState());

  final AuthRepository _authRepo;

  void onEmailChanged(String email) => emit(state.withEmail(email));
  void onPasswordChanged(String pwd) => emit(state.withPassword(pwd));
  void onConfirmedPasswordChanged(String confirmedPwd) =>
      emit(state.withConfirmedPassword(confirmedPwd));

  Future<void> signUpWithCredentials() async {
    if (!state.isValid) return;
    emit(state.withSubmissionInProgress());
    try {
      await _authRepo.signUpWithEmailAndPassword(
          email: state.email.value, password: state.password.value);
      emit(state.withSubmissionSuccess());
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(state.withSubmissionFailure(e.message));
    } catch (_) {
      emit(state.withSubmissionFailure());
    }
  }
}
