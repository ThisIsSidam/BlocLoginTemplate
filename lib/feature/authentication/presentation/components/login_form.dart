import 'package:blocloginexample/feature/authentication/presentation/bloc/login_cubit.dart';
import 'package:blocloginexample/feature/authentication/presentation/bloc/login_state.dart';
import 'package:blocloginexample/feature/authentication/presentation/views/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (_, s) {},
      child: SingleChildScrollView(
          child: Column(
        spacing: 12,
        children: [
          _EmailField(),
          _PasswordField(),
          _LoginButton(),
          _SignupButton()
        ],
      )),
    );
  }
}

class _EmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError =
        context.select((LoginCubit cubit) => cubit.state.email.displayError);

    return TextField(
      key: ValueKey('login_email_field'),
      onChanged: (email) => context.read<LoginCubit>().onEmailChanged(email),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'johndoe@email.com',
        errorText: displayError != null ? 'invalid email' : null,
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError =
        context.select((LoginCubit cubit) => cubit.state.password.displayError);

    return TextField(
      key: ValueKey('login_pwd_field'),
      onChanged: (pwd) => context.read<LoginCubit>().onPasswordChanged(pwd),
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: '********',
        errorText: displayError != null ? 'invalid password' : null,
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress =
        context.select((LoginCubit cubit) => cubit.state.status.isInProgress);
    if (isInProgress) return CircularProgressIndicator();

    final isValid = context.select(
      (LoginCubit cubit) => cubit.state.isValid,
    );

    return ElevatedButton(
      key: const Key('login_button'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: isValid
          ? () => context.read<LoginCubit>().loginWithCredentials()
          : null,
      child: const Text('Login'),
    );
  }
}

class _SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      key: const Key('login_form_signup_button'),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpScreen(),
        ),
      ),
      child: const Text('Sign Up'),
    );
  }
}
