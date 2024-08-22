import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cologne_store_mobile_app/Pages/main_page.dart';
import 'package:cologne_store_mobile_app/Pages/register.dart';
import 'package:cologne_store_mobile_app/Provider/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  int emailCounter = 0;
  int passwordCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome!', style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),),
                  SizedBox(width: 20,),
                  Icon(Icons.waving_hand_rounded)
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email address";
                    } else if (!value.contains('@')) {
                      return "Email must contain @ symbol";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                      ),
                      labelText: 'Email address'),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    } else if (value.length < 7) {
                      return "Password needs to be at least 8 characters";
                    } else if (!value.contains('@')) {
                      return "Password must contain @ symbol";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                      ),
                      labelText: 'Password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register()));
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.lightGreen,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              Consumer<EmailProvider>(
                builder: (context, value, child) => ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        context.read<EmailProvider>().getUserEmail(emailController.text);
                        _login();
                      }
                    },
                    child: const Icon(
                      Icons.thumb_up_alt_outlined,
                      color: Colors.lightGreen,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    var num = await FirebaseFirestore.instance
        .collection("Users")
        .where("email", isEqualTo: emailController.text)
        .where("password", isEqualTo: passwordController.text)
        .get();

    setState(() {
      emailCounter = num.size;
      passwordCounter = num.size;
    });

    if (emailCounter == 1 && passwordCounter == 1) {
      log('User logged in successfully!');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login successful!"),
        ),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("ok"),
            ),
          ],
          title: const Text("Unauthorized"),
          contentPadding: const EdgeInsets.all(15),
          content: const Text("You are not registered as a user."),
        ),
      );
      log("User not signed in");
    }
  }
}
