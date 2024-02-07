import 'package:myapp/model/user.dart';
import 'package:myapp/services/auth_methods.dart';

class UserRepo {
  final FirebaseAuthMethods firebasemethod;

  UserRepo({required this.firebasemethod});

  Future<UserModel> fetchUser() async {
    return await firebasemethod.fetchUserData();
  }
}
