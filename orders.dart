import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cologne_store_mobile_app/Provider/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Consumer<EmailProvider>(
          builder: (context, value, child) => Container(
            decoration: const BoxDecoration(),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Orders')
                    .where('email', isEqualTo: value.userEmail)
                    .snapshots(),
                builder: (context, snapshot) {
                  List<Column> orderWidgets = [];

                  if (snapshot.hasData) {
                    final orders = snapshot.data?.docs.reversed.toList();

                    for (var order in orders!) {
                      final orderWidget = Column(
                        children: [
                          Card(
                            elevation: 25,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const Column(
                                        children: [
                                          Text("First name:"),
                                          SizedBox(
                                            height: 17,
                                          ),
                                          Text("Last name:"),
                                          SizedBox(
                                            height: 17,
                                          ),
                                          Text("Payment method:"),
                                          SizedBox(
                                            height: 17,
                                          ),
                                          Text("Date and time:"),
                                          SizedBox(
                                            height: 17,
                                          ),
                                          Text("Order status:"),
                                          SizedBox(
                                            height: 17,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            order['first name'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(order['last name'],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(order['payment method'],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(order['date'],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text("Succesful",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 3,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        size: 50,
                                        color: Colors.green,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      );
                      orderWidgets.add(orderWidget);
                    }
                  }
                  return ListView(
                    children: orderWidgets,
                  );
                }),
          ),
        ),
      ),
    );
  }
}
