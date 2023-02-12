import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/resources/models.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMehtods {
  // creating instances for firebase methods
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // function to get user details
  Future<UserModels> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("user")
        .doc(currentUser.uid)
        .get();

    return UserModels.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        // register user
        UserCredential credentials = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(credentials.user!.uid);

        // storing data
        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profile_pics", file, false);

        // creating an instance of the user

        UserModels user = UserModels(
          username: username,
          uid: credentials.user!.uid,
          email: email,
          bio: bio,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );

        //add user to our database
        await _firestore
            .collection('users')
            .doc(credentials.user!.uid)
            .set(user.toJson());

        res = "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        res = "This email is already in use";
      } else if (e.code == "weak-password") {
        res = "Use a strong password";
      } else if (e.code == "invalid-email") {
        res = "This is not a valid email";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = "The user does not exist";
      } else if (e.code == 'wrong-password') {
        res = "Incorrect password";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
