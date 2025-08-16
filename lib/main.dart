import 'package:blocloginexample/feature/app/presentation/views/my_app.dart';
import 'package:blocloginexample/feature/authentication/data/repositories/auth_repository.dart';
import 'package:blocloginexample/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final repo = AuthRepository();
  await repo.user.first;

  runApp(MyApp(authRepository: repo));
}
