import 'package:blocloginexample/feature/authentication/data/repositories/auth_repository.dart';
import 'package:blocloginexample/feature/authentication/presentation/bloc/sign_up_cubit.dart';
import 'package:blocloginexample/feature/authentication/presentation/components/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Sign Up')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (context) => SignUpCubit(context.read<AuthRepository>()),
            child: SignUpForm(),
          ),
        ));
  }
}
