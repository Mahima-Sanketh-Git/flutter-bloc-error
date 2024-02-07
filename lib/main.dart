import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Authentication_flow.dart';
import 'package:myapp/bloc/authentication_bloc.dart';

import 'package:myapp/bloc_obverse.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/repositary/user_repo.dart';
import 'package:myapp/services/auth_methods.dart';

void main() async {
  Bloc.observer = AppBlocObverse();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepo(firebasemethod: FirebaseAuthMethods()),
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          context.read<UserRepo>(),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Crud Bloc Pattern',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.black,
          ),
          home: const AuthFlow(),
        ),
      ),
    );
  }
}
