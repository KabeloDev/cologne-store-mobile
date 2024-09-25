import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cologne_store_mobile_app/Pages/addReview.dart';
import 'package:cologne_store_mobile_app/Provider/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          color: Colors.lightGreen,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddReview()));
          },
          child: const Icon(Icons.type_specimen),
        ),
      ),
      body: Consumer<EmailProvider>(
        builder: (context, value, child) => Container(
          decoration: const BoxDecoration(),
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Reviews').snapshots(),
              builder: (context, snapshot) {
                List<Column> cologneWidgets = [];

                if (snapshot.hasData) {
                  final colognes = snapshot.data?.docs.reversed.toList();

                  for (var cologne in colognes!) {
                    final cologneWiget = Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("User: ${cologne['email']}"),
                                ],
                              ),
                              Text("Cologne: ${cologne['cologne name']}"),
                              Text("Review: ${cologne['review message']}"),
                              Row(
                                children: [
                                  Text("Rating: ${cologne['rating']} out 5"),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Divider(),
                              ),
                              const SizedBox(height: 5,)
                            ],
                          ),
                        ),
                      ],
                    );
                    cologneWidgets.add(cologneWiget);
                  }
                }
                return ListView(
                  children: cologneWidgets,
                );
              }),
        ),
      ),
    );
  }
}
