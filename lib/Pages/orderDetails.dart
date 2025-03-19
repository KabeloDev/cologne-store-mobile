import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cologne_store_mobile_app/Provider/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 225, 225),
      appBar: AppBar(
        title: const Text('Order details'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 102, 182, 116),
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
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Deliver for:"),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Text("Delivery to:"),
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
                                          Text("Cologne:"),
                                          SizedBox(
                                            height: 17,
                                          ),
                                          Text("Price:"),
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
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          // Text(
                                          //   order['last name'],
                                          //   style: const TextStyle(
                                          //       fontSize: 17,
                                          //       fontWeight: FontWeight.bold,
                                          //       fontStyle: FontStyle.italic),
                                          // ),
                                          // const SizedBox(
                                          //   height: 2,
                                          // ),
                                          Text(
                                            order['address'],
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Text(
                                            order['payment method'],
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Text(
                                            order['date'],
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Text(
                                            "${order['name']} ${order['brand']}",
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Text(
                                            "R${order['price']}",
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 50, right: 50),
                                    child: Divider(),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        order['image'],
                                        height: 70,
                                        width: 70,
                                      ),
                                      const Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.lightGreen,
                                        size: 40,
                                      )
                                    ],
                                  ),
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
