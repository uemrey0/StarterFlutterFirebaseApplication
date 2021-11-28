import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:massage_new/main.dart';
import 'package:massage_new/services/auth.dart';
import 'package:matcher/matcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const Register({
    Key? key,
    required this.auth,
    required this.firestore,
  }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  bool isAgreed = false;
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
                "Register",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: TextFormField(
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          border: UnderlineInputBorder(),
                        ),
                        autofocus: true,
                        controller: _nameController),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: TextFormField(
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          labelText: "Surname",
                          border: UnderlineInputBorder(),
                        ),
                        controller: _surnameController),
                  ),
                ],
              ),
              TextFormField(
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  labelText: "Mail",
                  border: UnderlineInputBorder(),
                ),
                controller: _emailController,
              ),
              TextFormField(
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: UnderlineInputBorder(),
                ),
                controller: _passwordController,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isAgreed,
                    onChanged: (bool? value) {
                      setState(() {
                        isAgreed = value!;
                      });
                    },
                  ),
                  const Text("I agree blablabla :)"),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              OutlineButton(
                onPressed: () async {
                  if (isAgreed) {
                    final String retVal =
                        await Auth(auth: widget.auth).createAccount(
                      email: _emailController.text,
                      password: _passwordController.text,
                      name: _nameController.text,
                      surname: _surnameController.text,
                    );
                    if (retVal == "Success") {
                      _emailController.clear();
                      _passwordController.clear();
                      _nameController.clear();
                      _surnameController.clear();
                      //Navigator.push(context,
                      //MaterialPageRoute(builder: (context) => Root()));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CompleteRegister()));
                    } else {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(retVal),
                        ),
                      );
                    }
                  } else {
                    Scaffold.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Agree blablabla"),
                      ),
                    );
                  }
                },
                child: const Text("Register"),
              ),
            ],
          );
        }),
      ),
    ));
  }
}

class CompleteRegister extends StatefulWidget {
  const CompleteRegister({Key? key}) : super(key: key);

  @override
  _CompleteRegisterState createState() => _CompleteRegisterState();
}

class _CompleteRegisterState extends State<CompleteRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Builder(builder: (BuildContext context) {
            return Column(
              children: [],
            );
          }),
        ),
      ),
    );
  }
}
