import 'package:blocloginexample/core/exceptions/auth_exceptions.dart';
import 'package:blocloginexample/feature/authentication/data/repositories/auth_repository.dart';
import 'package:blocloginexample/feature/authentication/presentation/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepo) : super(const LoginState());

  final AuthRepository _authRepo;

  void onEmailChanged(String email) => emit(state.withEmail(email));
  void onPasswordChanged(String pwd) => emit(state.withPassword(pwd));

  Future<void> loginWithCredentials() async {
    if (!state.isValid) return;
    emit(state.withSubmissionInProgress());
    try {
      await _authRepo.loginWithEmailAndPassword(
          email: state.email.value, password: state.password.value);
      emit(state.withSubmissionSuccess());
    } on LoginWithEmailAndPasswordFailure catch (e) {
      emit(state.withSubmissionFailure(e.message));
    } catch (_) {
      emit(state.withSubmissionFailure());
    }
  }

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
