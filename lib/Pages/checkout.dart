//import 'package:cologne_store_mobile_app/Pages/main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cologne_store_mobile_app/Pages/main_page.dart';
import 'package:cologne_store_mobile_app/Provider/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();

  List<String> paymentMethods = ["Cash on delivery", "Online"];

  String? payment = "Cash on delivery";

  final formKey = GlobalKey<FormState>();

  final firestoreCart = FirebaseFirestore.instance.collection("Cart");
  final firestoreOrders = FirebaseFirestore.instance.collection("Orders");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Consumer<EmailProvider>(
          builder: (context, value, child) =>
          Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: firstNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter yout first name";
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
                            labelText: 'First name'),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: lastNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter yout last name";
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
                            labelText: 'Last name'),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLines: 5,
                        controller: addressController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your address";
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
                            labelText: 'Address'),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            'Payment method:',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          DropdownButton(
                            value: payment,
                            onChanged: (newPaymentMethod) {
                              setState(() {
                                payment = newPaymentMethod.toString();
                              });
                            },
                            items: paymentMethods.map((valueItem) {
                              return DropdownMenuItem(
                                  value: valueItem, child: Text(valueItem));
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            String id = firestoreOrders.doc().id;
                            final now = DateTime.now();
                            var time = DateTime(now.year, now.month, now.day, now.hour, now.minute).toString();
                            await FirebaseFirestore.instance
                                .collection('Orders')
                                .doc(id)
                                .set({
                              "first name": firstNameController.text,
                              "last name": lastNameController.text,
                              "address": addressController.text,
                              "payment method": payment,
                              "email" : value.userEmail,
                              "date": time,
                              "id" : id
                            });
                             ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Payment succesful! Have a nice day."),
                              ),
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainPage()));
                          }
                        },
                        child: const Icon(
                          Icons.monetization_on,
                          color: Colors.lightGreen,
                        ))
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
