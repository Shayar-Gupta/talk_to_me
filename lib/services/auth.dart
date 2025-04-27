import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:talk_to_me/screens/home.dart';
import 'package:talk_to_me/services/database.dart';
import 'package:talk_to_me/services/shared_pref.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrUser() async {
    return auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken);

    UserCredential result = await firebaseAuth.signInWithCredential(credential);

    User? userDetails = result.user;

    String username = userDetails!.email!.replaceAll("@gmail.com", "");
    String firstLetter = username.substring(0, 1).toUpperCase();

    await SharedpreferenceHelper()
        .saveUserDisplayName(userDetails.displayName!);
    await SharedpreferenceHelper().saveUserEmail(userDetails.email!);
    await SharedpreferenceHelper().saveUserId(userDetails.uid);
    await SharedpreferenceHelper().saveUserName(username);
    await SharedpreferenceHelper().saveUserImage(userDetails.photoURL!);

    if (result != null) {
      Map<String, dynamic> userInfoMap = {
        "Name": userDetails!.displayName,
        "Email": userDetails!.email,
        "Image": userDetails.photoURL,
        "id": userDetails.uid,
        "username": username.toUpperCase(),
        "SearchKey": firstLetter,
      };

      await DatabaseMethods()
          .addUser(userInfoMap, userDetails!.uid)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Register ho gaye aap",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
            )));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));  //pushReplacment because pop.remove so user do not move back to signup page
      });
    }
  }
}
