import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/model/user.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> fetchUserData() async {
    User user = _auth.currentUser!;
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(user.uid).get();

    // print('-------------------------------------------');
    // print(snap["name"]);
    return UserModel.fromSnapshot(snapshot);
  }

  Future<String> createUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = 'some error ocuured';
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        UserModel userModel = UserModel(id: user.uid, email: email, name: name);
        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(userModel.toJason());
        res = "success";
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return res;
  }

  Future<void> signOut() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _auth.signOut();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
