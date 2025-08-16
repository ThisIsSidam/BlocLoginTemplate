import 'package:blocloginexample/feature/authentication/presentation/bloc/sign_up_cubit.dart';
import 'package:blocloginexample/feature/authentication/presentation/bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (_, s) {},
      child: SingleChildScrollView(
          child: Column(
        spacing: 12,
        children: [
          _EmailField(),
          _PasswordField(),
          _ConfirmedPasswordField(),
          _SignupButton(),
          _LoginButton(),
        ],
      )),
    );
  }
}

class _EmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError =
        context.select((SignUpCubit cubit) => cubit.state.email.displayError);

    return TextField(
      key: ValueKey('signup_email_field'),
      onChanged: (email) => context.read<SignUpCubit>().onEmailChanged(email),
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
    final displayError = context
        .select((SignUpCubit cubit) => cubit.state.password.displayError);

    return TextField(
      key: ValueKey('signup_pwd_field'),
      onChanged: (pwd) => context.read<SignUpCubit>().onPasswordChanged(pwd),
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: '********',
        errorText: displayError != null ? 'invalid password' : null,
      ),
    );
  }
}

class _ConfirmedPasswordField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
        (SignUpCubit cubit) => cubit.state.confirmedPassword.displayError);

    return TextField(
      key: ValueKey('signup_confirmed_pwd_field'),
      onChanged: (pwd) =>
          context.read<SignUpCubit>().onConfirmedPasswordChanged(pwd),
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        hintText: '********',
        errorText: displayError != null ? 'password does not match' : null,
      ),
    );
  }
}

class _SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress =
        context.select((SignUpCubit cubit) => cubit.state.status.isInProgress);
    if (isInProgress) return CircularProgressIndicator();

    final isValid = context.select(
      (SignUpCubit cubit) => cubit.state.isValid,
    );

    return ElevatedButton(
      key: const Key('sign_up_button'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: isValid
          ? () => context.read<SignUpCubit>().signUpWithCredentials()
          : null,
      child: const Text('Sign Up'),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      key: const Key('sign_up_form_login_button'),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () => Navigator.pop(context),
      child: const Text('Login'),
    );
  }
}
