import 'package:authenticator/components/my_button.dart';
import 'package:authenticator/components/my_textfield.dart';
import 'package:authenticator/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop the loading cirlce
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      // wrong email
      if (e.code == 'user-not-found') {
        // show error to user
        wrongEmailMessage();
      }

      // wrong password
      else if (e.code == 'wrong-password') {
        // show error to user
        wrongPasswordMessage();
      }
    }
  }

  //wrong email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Incorrect Email'),
        );
      },
    );
  }

  //wrong email message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Incorrect Password'),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 35),

              // logo
              Icon(
                Icons.lock,
                size: 80,
              ),

              SizedBox(height: 35),

              // welcome back , you've been missed!
              Text(
                'Welcome back. you\'ve been missed ',
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

              // forgot password
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot password ?',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // sign in button
              MyButton(
                onTap: signUserIn,
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
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Register now',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
