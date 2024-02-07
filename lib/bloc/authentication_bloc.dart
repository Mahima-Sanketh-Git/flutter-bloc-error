import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myapp/model/user.dart';
import 'package:myapp/repositary/user_repo.dart';

import 'package:myapp/services/auth_methods.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepo userRepo;
  final FirebaseAuthMethods firebaseAuthMethods = FirebaseAuthMethods();
  AuthenticationBloc(this.userRepo) : super(AuthenticationInitial()) {
    on<UserAuthenticationEvent>(_userAuth);
    on<UserLogOut>(_logOut);
    on<FetchUserData>(_fetchData);
  }

  void _userAuth(
      UserAuthenticationEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthLodingState(isloadin: true));
    try {
      final String user = await firebaseAuthMethods.createUser(
          email: event.email, password: event.password, name: event.name);

      if (user == 'success') {
        emit(AuthSuccessState());
      } else {
        emit(AuthFaliureState(error: 'Error - User Not Created '));
      }
    } catch (e) {
      print(e.toString());
    }
    emit(AuthLodingState(isloadin: false));
  }

  void _logOut(UserLogOut event, Emitter<AuthenticationState> emit) async {
    emit(AuthLodingState(isloadin: true));
    try {
      await firebaseAuthMethods.signOut();
    } catch (e) {
      print(e.toString());
    }
    emit(AuthLodingState(isloadin: false));
    // emit(AuthenticationInitial());
  }

  void _fetchData(
      FetchUserData event, Emitter<AuthenticationState> emit) async {
    emit(AuthLodingState(isloadin: true));
    try {
      final UserModel userModel = await userRepo.fetchUser();
      emit(UserDataState(userModel: userModel));
    } catch (e) {
      print(e.toString());
    }
    emit(AuthLodingState(isloadin: false));
  }
}
