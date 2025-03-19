import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cologne_store_mobile_app/Pages/orderDetails.dart';
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
      backgroundColor: const Color.fromARGB(255, 225, 225, 225),
      appBar: AppBar(
        title: const Text('Items Ordered'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 102, 182, 116),
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const OrderDetails()));
          },
          color: Colors.lightGreen,
          child: const Icon(Icons.info),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Consumer<EmailProvider>(
          builder: (context, value, child) => Container(
            decoration: const BoxDecoration(),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Cart')
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
                                      /*const Column(
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
                                      ),*/
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Image.network(
                                            order['image'],
                                            height: 100,
                                            width: 100,
                                            /*style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),*/
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(order['brand'],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(order['name'],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text('R${order['price']}',
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
