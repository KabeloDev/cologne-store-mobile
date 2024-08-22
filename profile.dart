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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dobController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final iDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
      ),
      body: Consumer<EmailProvider>(
        builder: (context, value, child) => Container(
          decoration: const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                          style: TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  profile['email'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Password:',
                          style: TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  profile['password'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        actions: [
                                          Consumer(
                                            builder: (context, value, child) =>
                                                TextButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('Users')
                                                    .doc(profileId)
                                                    .update({
                                                  'password':
                                                      passwordController.text
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Update'),
                                            ),
                                          ),
                                        ],
                                        title: const Text('Update password'),
                                        content: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: TextFormField(
                                                controller: passwordController,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter your password";
                                                  } else if (value.length < 7) {
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
                                  child: const Icon(Icons.edit),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Date of birth:',
                          style: TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  profile['DOB'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        actions: [
                                          Consumer(
                                            builder: (context, value, child) =>
                                                TextButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('Users')
                                                    .doc(profileId)
                                                    .update({
                                                  'DOB': dobController.text
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Update'),
                                            ),
                                          ),
                                        ],
                                        title:
                                            const Text('Update date of birth'),
                                        content: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: TextFormField(
                                                controller: dobController,
                                                keyboardType:
                                                    TextInputType.datetime,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter date of birth";
                                                  }
                                                  return null;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: "Date of birth",
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
                                  child: const Icon(Icons.edit),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Phone number:',
                          style: TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  profile['phone number'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        actions: [
                                          Consumer(
                                            builder: (context, value, child) =>
                                                TextButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('Users')
                                                    .doc(profileId)
                                                    .update({
                                                  'phone number':
                                                      phoneNumberController.text
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Update'),
                                            ),
                                          ),
                                        ],
                                        title:
                                            const Text('Update phone number'),
                                        content: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: TextFormField(
                                                controller:
                                                    phoneNumberController,
                                                keyboardType:
                                                    TextInputType.datetime,
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
                                  child: const Icon(Icons.edit),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'ID:',
                          style: TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  profile['ID'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        actions: [
                                          Consumer(
                                            builder: (context, value, child) =>
                                                TextButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('Users')
                                                    .doc(profileId)
                                                    .update({
                                                  'ID': iDController.text
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Update'),
                                            ),
                                          ),
                                        ],
                                        title: const Text('Update ID'),
                                        content: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: TextFormField(
                                                controller: iDController,
                                                keyboardType:
                                                    TextInputType.number,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter ID";
                                                  }
                                                  return null;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: "ID",
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
                                  child: const Icon(Icons.edit),
                                )
                              ],
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
