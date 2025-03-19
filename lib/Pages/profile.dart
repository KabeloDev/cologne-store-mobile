import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cologne_store_mobile_app/Provider/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dobController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final iDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 225, 225),
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 102, 182, 116),
        foregroundColor: Colors.white,
      ),
      body: Consumer<EmailProvider>(
        builder: (context, value, child) => Container(
          decoration: const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .where('email', isEqualTo: value.userEmail)
                  .snapshots(),
              builder: (context, snapshot) {
                List<Column> profileWidgets = [];

                if (snapshot.hasData) {
                  final profiles = snapshot.data?.docs.reversed.toList();
                  for (var profile in profiles!) {
                    //String email = profile['email'];
                    String profileId = profile['id'];
                    final profileWidget = Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'Email:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 80,
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    profile['email'],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'First name:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 80,
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    profile['first name'],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 21, 21, 21),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            actions: [
                                              Consumer(
                                                builder:
                                                    (context, value, child) =>
                                                        TextButton(
                                                  onPressed: () async {
                                                    if (firstNameController
                                                        .text.isNotEmpty) {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('Users')
                                                          .doc(profileId)
                                                          .update({
                                                        'first name':
                                                            firstNameController
                                                                .text
                                                      });
                                                    }
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Update'),
                                                ),
                                              ),
                                            ],
                                            title:
                                                const Text('Update first name'),
                                            content: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: TextFormField(
                                                    controller:
                                                        firstNameController,
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: "First name",
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Last name:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 80,
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    profile['last name'],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 21, 21, 21),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            actions: [
                                              Consumer(
                                                builder:
                                                    (context, value, child) =>
                                                        TextButton(
                                                  onPressed: () async {
                                                    if (lastNameController
                                                        .text.isNotEmpty) {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('Users')
                                                          .doc(profileId)
                                                          .update({
                                                        'last name':
                                                            lastNameController
                                                                .text
                                                      });
                                                    }
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Update'),
                                                ),
                                              ),
                                            ],
                                            title:
                                                const Text('Update last name'),
                                            content: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: TextFormField(
                                                    controller:
                                                        lastNameController,
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: "Last name",
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Password:',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 80,
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    profile['password'],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 21, 21, 21),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            actions: [
                                              Consumer(
                                                builder:
                                                    (context, value, child) =>
                                                        TextButton(
                                                  onPressed: () async {
                                                    if (passwordController
                                                            .text.isNotEmpty &&
                                                        passwordController
                                                                .text.length >
                                                            7 &&
                                                        passwordController.text
                                                            .contains('@')) {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('Users')
                                                          .doc(profileId)
                                                          .update({
                                                        'password':
                                                            passwordController
                                                                .text
                                                      });
                                                    }
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Update'),
                                                ),
                                              ),
                                            ],
                                            title:
                                                const Text('Update password'),
                                            content: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: TextFormField(
                                                    controller:
                                                        passwordController,
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Please enter your password";
                                                      } else if (value.length <
                                                          7) {
                                                        return "Password needs to be at least 8 characters";
                                                      } else if (!value
                                                          .contains('@')) {
                                                        return "Password must contain @ symbol";
                                                      }
                                                      return null;
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: "Password",
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Icon(Icons.edit,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Phone number:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 80,
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    profile['phone number'],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 21, 21, 21),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            actions: [
                                              Consumer(
                                                builder:
                                                    (context, value, child) =>
                                                        TextButton(
                                                  onPressed: () async {
                                                    if (phoneNumberController
                                                            .text.isNotEmpty &&
                                                        phoneNumberController
                                                                .text.length ==
                                                            10) {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('Users')
                                                          .doc(profileId)
                                                          .update({
                                                        'phone number':
                                                            phoneNumberController
                                                                .text
                                                      });
                                                    }
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Update'),
                                                ),
                                              ),
                                            ],
                                            title: const Text(
                                                'Update phone number'),
                                            content: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: TextFormField(
                                                    controller:
                                                        phoneNumberController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Please enter phone number";
                                                      }
                                                      return null;
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: "Phone number",
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'ID:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 80,
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    profile['ID'],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    );
                    profileWidgets.add(profileWidget);
                  }
                }
                return ListView(
                  children: profileWidgets,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
