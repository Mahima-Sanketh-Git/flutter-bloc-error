import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/authentication_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthenticationBloc>(context).add(FetchUserData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthLodingState) {
            if (state.isloadin == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
          if (state is UserDataState) {
            return Text(state.userModel.name);
          }
          return Column(
            children: [
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is UserDataState) {
                    return Text(state.userModel.name);
                  }
                  return Container();
                },
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationBloc>().add(UserLogOut());
                },
                child: state is AuthLodingState
                    ? state.isloadin == true
                        ? const Text('.....')
                        : const Text("Log Out")
                    : null,
              )
            ],
          );
        },
      ),
    );
  }
}
