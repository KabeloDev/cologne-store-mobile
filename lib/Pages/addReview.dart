import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cologne_store_mobile_app/Pages/reviews.dart';
import 'package:cologne_store_mobile_app/Provider/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddReview extends StatefulWidget {
  const AddReview({super.key});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  List<String> gameList = ["1", "2", "3", "4", "5"];
  var selectedValue;

  final formKey = GlobalKey<FormState>();

  final cologneController = TextEditingController();
  final reviewController = TextEditingController();

  final firestoreReviews = FirebaseFirestore.instance.collection("Reviews");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 225, 225),
      appBar: AppBar(
        title: const Text('Add Review'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 102, 182, 116),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Consumer<EmailProvider>(
          builder: (context, value, child) => Padding(
            padding: const EdgeInsets.all(50),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Cologne'),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: cologneController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a cologne";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        labelText: 'cologne name...',
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Review message'),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: 5,
                      controller: reviewController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a review";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          labelText: 'review message...'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Rate the cologne out of 5'),
                  const SizedBox(
                    height: 5,
                  ),
                  DropdownButton<String>(
                    value: selectedValue,
                    items:
                        gameList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        String id = firestoreReviews.doc().id;
                        // final now = DateTime.now();
                        // var time = DateTime(now.year, now.month, now.day, now.hour, now.minute).toString();
                        await FirebaseFirestore.instance
                            .collection('Reviews')
                            .doc(id)
                            .set({
                          "cologne name": cologneController.text,
                          "review message": reviewController.text,
                          "rating": selectedValue,
                          "first name": value.userFirstName,
                          "last name": value.userLastName,
                          "email": value.userEmail,
                          "id": id
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Review succesfully sent!."),
                          ),
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Reviews()));
                      }
                    },
                    child: const Icon(
                      Icons.thumb_up_alt_outlined,
                      color: const Color.fromARGB(255, 102, 182, 116),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
