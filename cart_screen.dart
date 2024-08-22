import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cologne_store_mobile_app/Pages/checkout.dart';
import 'package:cologne_store_mobile_app/Provider/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Checkout()));
          },
          color: Colors.lightGreen,
          child: const Icon(Icons.shopping_cart_checkout),
        ),
      ),
      body: Consumer<EmailProvider>(
        builder: (context, value, child) => Container(
          decoration: const BoxDecoration(),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Cart')
                  .where('email', isEqualTo: value.userEmail)
                  .snapshots(),
              builder: (context, snapshot) {
                List<Column> cologneWidgets = [];

                if (snapshot.hasData) {
                  final colognes = snapshot.data?.docs.reversed.toList();

                  for (var cologne in colognes!) {
                    final cologneWiget = Column(
                      children: [
                        ListTile(
                          leading: Image.network(
                              'https://i.pinimg.com/736x/89/9a/30/899a3075798ce40e92ea4d4ccb418f4b.jpg'),
                          title: Text(cologne['name']),
                          subtitle: Text(
                              '${cologne['brand']} \nR${cologne['price']}'),
                          trailing: InkWell(
                            onTap: () async {
                              String cologneId = cologne['id'];
                              await FirebaseFirestore.instance
                                  .collection('Cart')
                                  .doc(cologneId)
                                  .delete();
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Item removed from cart"),
                                ),
                              );
                            },
                            child: const Icon(Icons.delete),
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
