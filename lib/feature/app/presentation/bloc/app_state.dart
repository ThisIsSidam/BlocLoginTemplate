import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AppStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState({User? user})
      : this._(
            status: user == null
                ? AppStatus.unauthenticated
                : AppStatus.authenticated,
            user: user);

  const AppState._({required this.status, this.user});

  final AppStatus status;
  final User? user;

  @override
  List<Object?> get props => [status, user];
}
