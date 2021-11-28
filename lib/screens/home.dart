import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:massage_new/screens/login.dart';
import 'package:matcher/matcher.dart';
import 'package:massage_new/services/auth.dart';

class Home extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const Home({Key? key, required this.auth, required this.firestore})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messageless"),
        backgroundColor: const Color.fromARGB(1000, 46, 76, 109),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(0, 0, 0, 0)),
        // ignore: deprecated_member_use
        backwardsCompatibility: false,
        actions: [
          IconButton(
              onPressed: () async {
                final String retVal = await Auth(auth: widget.auth).SignOut(
                  email: '',
                  password: '',
                );
                if (retVal == "Success") {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(retVal),
                    ),
                  );
                } else {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(retVal),
                    ),
                  );
                }
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
