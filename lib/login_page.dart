import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/authentication_bloc.dart';
import 'package:myapp/home_scree.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailcontroler = TextEditingController();
  final TextEditingController _passwordcontroler = TextEditingController();
  final TextEditingController _namecontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthFaliureState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(state.error),
            ),
          );
        } else if (state is AuthSuccessState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign in.',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 38,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: Column(
                          children: [
                            TextField(
                              controller: _emailcontroler,
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                contentPadding: EdgeInsets.all(8),
                                enabled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.pinkAccent),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: _passwordcontroler,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                contentPadding: EdgeInsets.all(8),
                                enabled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.pinkAccent),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: _namecontroler,
                              obscureText: false,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                contentPadding: EdgeInsets.all(8),
                                enabled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.pinkAccent),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                context.read<AuthenticationBloc>().add(
                                      UserAuthenticationEvent(
                                        _emailcontroler.text.trim(),
                                        _passwordcontroler.text.trim(),
                                        _namecontroler.text.trim(),
                                      ),
                                    );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 50,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.purpleAccent,
                                      Colors.pinkAccent
                                    ],
                                  ),
                                ),
                                child: state is AuthLodingState
                                    ? state.isloadin == true
                                        ? const Text('........')
                                        : const Text(
                                            "Sign in",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20,
                                                color: Colors.white),
                                          )
                                    : const Text(
                                        "Sign in",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
