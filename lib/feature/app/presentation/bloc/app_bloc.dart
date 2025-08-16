import 'package:blocloginexample/feature/app/presentation/bloc/app_event.dart';
import 'package:blocloginexample/feature/app/presentation/bloc/app_state.dart';
import 'package:blocloginexample/feature/authentication/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthRepository repo})
      : _authRepo = repo,
        super(AppState(user: repo.currentUser)) {
    on<AppUserSubscriptionRequested>(_onSubscriptionRequested);
    on<AppLogOutPressed>(_onLogoutPressed);
  }

  final AuthRepository _authRepo;

  Future<void> _onSubscriptionRequested(
      AppUserSubscriptionRequested state, Emitter<AppState> emit) {
    return emit.forEach(
      _authRepo.user,
      onData: (user) {
        final newState = AppState(user: user);
        emit(newState);
        return newState;
      },
    );
  }

  void _onLogoutPressed(AppLogOutPressed state, Emitter<AppState> emit) {
    _authRepo.logOut();
  }
}
