import 'package:blocloginexample/feature/app/presentation/bloc/app_bloc.dart';
import 'package:blocloginexample/feature/app/presentation/bloc/app_event.dart';
import 'package:blocloginexample/feature/app/presentation/bloc/app_state.dart';
import 'package:blocloginexample/feature/authentication/data/repositories/auth_repository.dart';
import 'package:blocloginexample/feature/authentication/presentation/views/login_screen.dart';
import 'package:blocloginexample/feature/home/presentation/view/home_screen.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({required AuthRepository authRepository, super.key})
      : _authRepo = authRepository;

  final AuthRepository _authRepo;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _authRepo,
        child: BlocProvider(
          lazy: false,
          create: (context) =>
              AppBloc(repo: _authRepo)..add(AppUserSubscriptionRequested()),
          child: AppView(),
        ));
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  List<Page<dynamic>> onGenerateAppViewPages(
    AppStatus state,
    List<Page<dynamic>> pages,
  ) {
    switch (state) {
      case AppStatus.authenticated:
        return [HomeScreen.page()];
      case AppStatus.unauthenticated:
        return [LoginScreen.page()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
