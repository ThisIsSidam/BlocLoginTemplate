import 'package:blocloginexample/feature/authentication/data/repositories/auth_repository.dart';
import 'package:blocloginexample/feature/authentication/presentation/bloc/login_cubit.dart';
import 'package:blocloginexample/feature/authentication/presentation/components/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (context) => LoginCubit(context.read<AuthRepository>()),
          child: LoginForm(),
        ),
      ),
    );
  }
}
