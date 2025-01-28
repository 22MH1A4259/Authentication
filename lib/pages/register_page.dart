// ignore_for_file: must_be_immutable

import 'package:authenticator/components/my_button.dart';
import 'package:authenticator/components/my_textfield.dart';
import 'package:authenticator/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confrimPasswordController = TextEditingController();

  // sign user in method
  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try creating  the user
    try {
      // check if password and confirm password are same
      if (passwordController.text == confrimPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        // show error messagee
        showErrorMessage('Passwords don\'t match ');
      }

      // pop the loading cirlce
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      // show error
      showErrorMessage(e.code);
    }
  }

  // error messaee to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.purple,
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),

                // logo
                Icon(
                  Icons.lock,
                  size: 50,
                ),

                SizedBox(height: 25),

                // Let\'s create an account for you
                Text(
                  'Let\'s create an account for you',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 18),

                // Email text field
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password text filed
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),
                // confirm password text filed
                MyTextField(
                  controller: confrimPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                // sign up button
                MyButton(
                  btnName: 'Sign Up',
                  onTap: signUserUp,
                ),

                const SizedBox(height: 35),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // google or apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(imagePath: 'lib/images/google.png'),

                    const SizedBox(width: 25),

                    // apple button
                    SquareTile(imagePath: "lib/images/apple.png")
                  ],
                ),

                const SizedBox(height: 15),

                // not a memeber? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
