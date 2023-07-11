import 'dart:convert';
import 'dart:math';

import 'package:blood_bank/models/patient_request.dart';
import 'package:blood_bank/models/user.dart';
import 'package:blood_bank/screens/auth/otp_input.dart';
import 'package:blood_bank/utils/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _uid;
  String get uid => _uid!;

  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthProvider() {
    checkSignedIn();
  }

  Future setSignIn() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signed_in", true);
    _isSignedIn = true;
    notifyListeners();
  }

  void checkSignedIn() async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    _isSignedIn = sf.getBool("is_signed_in") ?? false;
    notifyListeners();
  }

  // sign out
  Future signOut() async {
    // clear shared preferences
    await _auth.signOut();
    _isSignedIn = false;
    SharedPreferences s = await SharedPreferences.getInstance();
    notifyListeners();
    s.clear();
  }

  // verify otp
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String otp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential cred = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);

      User? user = (await _auth.signInWithCredential(cred)).user;

      if (user != null) {
        _uid = user.uid;
        onSuccess();
      }

      // stop loading
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // stop loading
      _isLoading = false;
      MyWidget.showSnackBar(context, e.message.toString());
    }
  }

  // sign in
  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (phoneAuthCredential) async {
            await _auth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        OtpInput(verificationId: verificationId)));
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      MyWidget.showSnackBar(context, e.message.toString());
    }
  }

// Database operations
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firestore.collection("users").doc(_uid).get();

    if (snapshot.exists) {
      print("user exists");
      return true;
    } else {
      print("user does not exists");
      return false;
    }
  }

  void storeUserData({
    required BuildContext context,
    required UserModel user,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // update values
      user.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
      user.phoneNumber = _auth.currentUser!.phoneNumber!;
      user.uid = _auth.currentUser!.uid;

      // update local state
      _userModel = user;

      // upload to database
      await _firestore
          .collection("users")
          .doc(_uid)
          .set(user.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      // stop loading
      _isLoading = false;
      MyWidget.showSnackBar(context, e.message.toString());
    }
  }

  Future getDataFromFirestore() async {
    String currentUserUid = _auth.currentUser!.uid;
    _firestore
        .collection("users")
        .doc(currentUserUid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
    });
  }

  // storing data locally
  Future storeDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  // fetching data from shared preferences
  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? "";
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid;
    notifyListeners();
  }

  // saving a request to database
  Future saveRequest(BuildContext context, PatientRequest request) async {
    _isLoading = true;
    try {
      // add phone number and createdAt
      request.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
      request.phoneNumber = _userModel!.phoneNumber;

      // add this data to firestore
      await _firestore
          .collection("requests")
          .doc(generateUniqueId())
          .set(request.toMap())
          .then((value) => _isLoading = false);
    } catch (e) {
      _isLoading = false;
      MyWidget.showSnackBar(context, e.toString());
    }
  }

  String generateUniqueId() {
    // create a random 12 digit alphanumeric string
    String randomString = "";

    const String characters =
        "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    for (int i = 0; i < 20; i++) {
      int index = Random().nextInt(characters.length);
      randomString += characters[index];

      // add a hyphen after 4 characters
      if (i % 4 == 0 && i != 0) {
        randomString += "-";
      }
    }

    return randomString;
  }
}
