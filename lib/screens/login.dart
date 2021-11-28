import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:massage_new/services/auth.dart';
import 'register.dart';

class Login extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const Login({
    Key? key,
    required this.auth,
    required this.firestore,
  }) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Builder(builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Log In",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(hintText: "Username"),
                controller: _emailController,
                autofocus: true,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(hintText: "Password"),
                controller: _passwordController,
              ),
              const SizedBox(
                height: 20,
              ),
              OutlineButton(
                onPressed: () async {
                  final String retVal = await Auth(auth: widget.auth).SignIn(
                      email: _emailController.text,
                      password: _passwordController.text);
                  if (retVal == "Success") {
                    _emailController.clear();
                    _passwordController.clear();
                  } else {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(retVal),
                      ),
                    );
                  }
                },
                child: const Text("Sign In"),
              ),
              Row(
                children: [
                  const Text("Don't you have an account yet?"),
                  TextButton(
                    onPressed: () async {
                      // register page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Register(
                                auth: widget.auth,
                                firestore: widget.firestore)),
                      );
                    },
                    child: const Text("Register"),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    ));
  }
}
