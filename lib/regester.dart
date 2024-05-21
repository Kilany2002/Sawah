// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sawah_app/generated/l10n.dart';
import 'package:sawah_app/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  Future<void> signup() async {
    if (passwordConfirmed()) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        User? user = userCredential.user;

        if (user != null) {
          await _firestore.collection('users').doc(user.uid).set({
            'name': nameController.text.trim(),
            'email': emailController.text.trim(),
            'phone': phoneController.text.trim(),
          });
        }

        _navigateToLogin();
        _showSuccessDialog();
      } catch (e) {
        // Handle error
        print(e);
      }
    }
  }

  bool passwordConfirmed() {
    return passwordController.text.trim() ==
        confirmPasswordController.text.trim();
  }

  Future<void> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          'phone': phoneController.text.trim(),
        });
      }

      _navigateToLogin();
      _showSuccessDialog();
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  Future<void> signUpWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        User? user = userCredential.user;

        if (user != null) {
          await _firestore.collection('users').doc(user.uid).set({
            'name': user.displayName ?? '',
            'email': user.email ?? '',
            'phone': phoneController.text.trim(),
          });
        }

        _navigateToLogin();
        _showSuccessDialog();
      }
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Successfully'),
          content: const Text('Signed up'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  late Color myColor;
  late Size mediaSize;
  bool rememberUser = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: AssetImage("assets/images/backk.png"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(top: 60, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (S.of(context).sawah),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 80,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          (S.of(context).welcome),
          style: TextStyle(
              color: myColor, fontSize: 30, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
        _buildGreyText((S.of(context).please_enter_your_information)),
        SizedBox(height: 30),
        _buildGreyText((S.of(context).name)),
        _buildInputField(nameController),
        SizedBox(height: 20),
        _buildGreyText((S.of(context).email_address)),
        _buildInputField(emailController),
        SizedBox(height: 20),
        _buildGreyText((S.of(context).phone_number)),
        _buildInputField(phoneController, isPhoneNumber: true),
        SizedBox(height: 20),
        _buildGreyText((S.of(context).password)),
        _buildInputField(passwordController, isPassword: true),
        SizedBox(height: 20),
        _buildGreyText((S.of(context).confirm_password)),
        _buildInputField(confirmPasswordController, isPassword: true),
        SizedBox(height: 20),
        _buildRememberForgot(),
        SizedBox(height: 20),
        _buildSignupButton(),
        SizedBox(height: 20),
        _buildOtherLogin(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {bool isPassword = false, bool isPhoneNumber = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? const Icon(Icons.remove_red_eye)
            : const Icon(Icons.done),
      ),
      obscureText: isPassword,
      keyboardType: isPhoneNumber ? TextInputType.phone : TextInputType.text,
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: _buildGreyText((S.of(context).already_have_an_account)))
          ],
        ),
      ],
    );
  }

  Widget _buildSignupButton() {
    return ElevatedButton(
      onPressed: signup,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: Text((S.of(context).signup)),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText((S.of(context).or_signup_with)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: signUpWithGoogle,
                child: Tab(icon: Image.asset("assets/images/google.png")),
              ),
              GestureDetector(
                onTap: signUpWithFacebook,
                child: Tab(icon: Image.asset("assets/images/facebook.png")),
              ),
            ],
          )
        ],
      ),
    );
  }
}
