import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:safetynetlk/models/user_model.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class UserModelProvider {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final StreamController<UserModel> _controller = StreamController();
  StreamSubscription<DocumentSnapshot>? docListener;

  //TODO:singleton
  UserModelProvider() {
    _controller.onListen = () {
      _firebaseAuth.idTokenChanges().listen((user) {
        handleAuthEvent(user);
      });
    };
    _controller.onCancel = () {
      docListener?.cancel();
      //TODO: cancel id tokenchanges listener?
    };
  }

  void handleAuthEvent(User? user) {
    if (user != null) {
      //cancel if existing
      docListener?.cancel();
      //listen to new user doc
      docListener = _firestore
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .listen((usersnap) {
        //if updated doc is received, then emit a UserModel
        _controller.add(modelFromSnapshot(usersnap));
      });
    } else {
      docListener?.cancel();
      _controller.add(emptyUserModel());
    }
  }

  static UserModel modelFromSnapshot(DocumentSnapshot userDoc) {
    if (userDoc.exists) {
      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      return UserModel(
        uid: data['uid'],
        name: data['name'],
        email: data['email'],
        city: data['city'],
        country: data['country'],
        photoProfile: data['photoProfile'],
        update: update,
        signIn: signIn,
        signUp: signUp,
        signInWithFacebook: signInWithFacebook,
        signOut: signOut,
      );
    } else {
      return emptyUserModel();
    }
  }

  Stream<UserModel> get userModel => _controller.stream;

  static Future<String> update(
      {required String name,
      required String country,
      required String city,
      required String photoProfile,
      required String uid}) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        "name": name,
        "country": country,
        'photoProfile': photoProfile,
        "city": city
      });
    } on FirebaseException catch (e) {
      e.message;
      return 'fail';
    }
    return 'success';
  }

  //............RUDIMENTARY METHODS FOR AUTHENTICATION................

  //SIGN UP METHOD
  static Future<String> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {
      return 'unknown error';
    }
  }

  //SIGN IN METHOD
  static Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          return 'Invalid Email';
        case 'ERROR_USER_NOT_FOUND':
          return 'User Not Found';
        case 'ERROR_WRONG_PASSWORD':
          return 'Wrong Password';
        default:
          return e.message!;
      }
    } catch (e) {
      return 'unknown error';
    }
  }

  //SIGN OUT METHOD
  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  static Future<void> signInWithFacebook() async {
    // Trigger the sign-in flow
    // final LoginResult loginResult = await FacebookAuth.instance.login();

    // // Create a credential from the access token
    // final OAuthCredential facebookAuthCredential =
    //     FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // // Once signed in, return the UserCredential
    // await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  static UserModel emptyUserModel() {
    return UserModel(
        update: update,
        signIn: signIn,
        signUp: signUp,
        signInWithFacebook: signInWithFacebook,
        signOut: signOut);
  }
}
