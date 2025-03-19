import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cologne_store_mobile_app/Auth%20Service/auth_service.dart';
import 'package:cologne_store_mobile_app/Pages/login.dart';
import 'package:cologne_store_mobile_app/Provider/email_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();

  final _auth = AuthService();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final dobController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final iDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 225, 225),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<EmailProvider>(
            builder: (context, value, child) => Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 102, 182, 116)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Welcome , we hope you find your signature scent here!.',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 66, 65, 65)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: firstNameController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 66, 65, 65),
                            fontWeight: FontWeight.bold),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your first name";
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
                            labelText: 'First Name',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 66, 65, 65),
                                fontWeight: FontWeight.bold))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: lastNameController,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 66, 65, 65),
                          fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your last name";
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
                          labelText: 'Last Name',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 66, 65, 65),
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: confirmController,
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
                        } else if (value != passwordController.text) {
                          return "Passwords must match";
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
                          labelText: 'Confirm password',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 66, 65, 65),
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: phoneNumberController,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 66, 65, 65),
                          fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your phone number";
                        } else if (value.length < 10 || value.length > 10) {
                          return "A phone number must be 10 digits";
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
                          labelText: 'Phone number',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 66, 65, 65),
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: iDController,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 66, 65, 65),
                          fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your ID";
                        } else if (value.length < 13 || value.length > 13) {
                          return "An ID number must be 13 digits";
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
                          labelText: 'ID',
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
                        const Text('Already have an account?'),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                          },
                          child: const Text(
                            'Login',
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
                    height: 20,
                  ),
                  ElevatedButton(
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

                          context
                              .read<EmailProvider>()
                              .getUserFirstName(firstNameController.text);

                          context
                              .read<EmailProvider>()
                              .getUserLastName(lastNameController.text);

                          _register();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Registration successful!"),
                            ),
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        }
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            color: Color.fromARGB(255, 233, 219, 186),
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _register() async {
    User? user = await _auth.createUserWithEmailAndPassword(
        emailController.text, passwordController.text);

    if (user != null) {
      String id = FirebaseFirestore.instance.collection('Users').doc().id;
      await FirebaseFirestore.instance.collection('Users').doc(id).set({
        "first name": firstNameController.text,
        "last name": lastNameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        // "date": DateTime.now(),
        "DOB": dobController.text,
        "phone number": phoneNumberController.text,
        "ID": iDController.text,
        "id": id
      });
    }
  }
}
