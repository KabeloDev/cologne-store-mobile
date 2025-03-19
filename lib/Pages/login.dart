import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cologne_store_mobile_app/Pages/home.dart';
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
      backgroundColor: const Color.fromARGB(255, 225, 225, 225),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 4,
                ),
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/cologne-store.appspot.com/o/images%2Fbec77e01-9ebb-4442-b539-7ed4f32fbeba.png?alt=media&token=ff0e3a0f-23ac-4e0c-9b7b-1e24ec928fe7',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'LOGIN',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 102, 182, 116)),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Welcome Back Friend, we missed you since the last time.',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 66, 65, 65)),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 66, 65, 65),
                        fontWeight: FontWeight.bold),
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
                        filled: true,
                        fillColor: Color.fromARGB(255, 164, 205, 182),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 84, 150, 113),
                              width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 84, 150, 113),
                              width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        labelText: 'Email address',
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 66, 65, 65),
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: passwordController,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 66, 65, 65),
                        fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: false,
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
                        filled: true,
                        fillColor: Color.fromARGB(255, 164, 205, 182),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 84, 150, 113),
                              width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 84, 150, 113),
                              width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 66, 65, 65),
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
                              color: Color.fromARGB(255, 102, 182, 116),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Consumer<EmailProvider>(
                  builder: (context, value, child) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 102, 182, 116),
                        minimumSize: const Size(420, 65),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          context
                              .read<EmailProvider>()
                              .getUserEmail(emailController.text);
                          _login();
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Color.fromARGB(255, 233, 219, 186),
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      )),
                )
              ],
            ),
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
          context, MaterialPageRoute(builder: (context) => const Home()));
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
