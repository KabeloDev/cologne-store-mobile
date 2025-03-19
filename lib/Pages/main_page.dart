/*import 'package:cologne_store_mobile_app/ApiHandler/api_handler.dart';
import 'package:cologne_store_mobile_app/Models/Cologne.dart';*/
//import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cologne_store_mobile_app/Pages/cart_screen.dart';
import 'package:cologne_store_mobile_app/Pages/home.dart';
import 'package:cologne_store_mobile_app/Pages/login.dart';
import 'package:cologne_store_mobile_app/Pages/orderDetails.dart';
import 'package:cologne_store_mobile_app/Pages/profile.dart';
import 'package:cologne_store_mobile_app/Pages/specials.dart';
import 'package:cologne_store_mobile_app/Provider/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
//import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MyMainPage();
}

class _MyMainPage extends State<MainPage> {
  String _sortOption = 'price_asc'; // Default sorting option

  void _sortColognes(List<DocumentSnapshot> colognes) {
    if (_sortOption == 'price_asc') {
      colognes.sort((a, b) => (a['price'] as num).compareTo(b['price'] as num));
    } else if (_sortOption == 'price_desc') {
      colognes.sort((a, b) => (b['price'] as num).compareTo(a['price'] as num));
    } else if (_sortOption == 'brand') {
      colognes.sort(
          (a, b) => (a['brand'] as String).compareTo(b['brand'] as String));
    }
  }

  List colognes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 225, 225),
      appBar: AppBar(
        title: const Text(
          "Montreal Odör",
          style: TextStyle(fontFamily: "Olivera", fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color.fromARGB(255, 28, 28, 28),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
            child: const Icon(Icons.shopping_basket_outlined),
          ),
          const SizedBox(width: 15),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          decoration: const BoxDecoration(
              color: const Color.fromARGB(255, 102, 182, 116),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                color: const Color.fromARGB(255, 102, 182, 116),
                elevation: 0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: const Icon(Icons.home),
              ),
              const SizedBox(width: 10),
              MaterialButton(
                color: const Color.fromARGB(255, 102, 182, 116),
                elevation: 0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Profile(),
                    ),
                  );
                },
                child: const Icon(Icons.person),
              ),
              const SizedBox(width: 10),
              MaterialButton(
                color: const Color.fromARGB(255, 102, 182, 116),
                elevation: 0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderDetails(),
                    ),
                  );
                },
                child: const Icon(Icons.attach_money),
              ),
              const SizedBox(width: 10),
              MaterialButton(
                color: const Color.fromARGB(255, 102, 182, 116),
                elevation: 0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
                child: const Icon(Icons.logout),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 29, 29, 29),
                  minimumSize: const Size(350, 120),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Specials(),
                    ),
                  );
                },
                child: Animate(
                  effects: const [FadeEffect(), ScaleEffect()],
                  child: const Text(
                    'Click Me See What\'s on SALE!!!!',
                    style: TextStyle(
                        color: Color.fromARGB(255, 87, 87, 87),
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )
                      .animate()
                      .fade(duration: 2000.ms)
                      .slideY(curve: Curves.easeIn),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Products",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                    PopupMenuButton<String>(
                      onSelected: (String result) {
                        setState(() {
                          _sortOption = result;
                        });
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                            value: 'price_asc',
                            child: Text('Price: Low to High')),
                        const PopupMenuItem(
                            value: 'price_desc',
                            child: Text('Price: High to Low')),
                        const PopupMenuItem(
                            value: 'brand', child: Text('Sort by Type')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Consumer<EmailProvider>(
                builder: (context, value, child) => Container(
                  decoration: const BoxDecoration(),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Colognes')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      final colognes =
                          snapshot.data?.docs.reversed.toList() ?? [];
                      _sortColognes(colognes);
                      return GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    2, // Change this to set the number of columns
                                childAspectRatio:
                                    0.6, // Adjust this ratio for item sizing
                                crossAxisSpacing: 3,
                                mainAxisSpacing: 3),
                        itemCount: colognes.length,
                        itemBuilder: (context, index) {
                          final cologne = colognes[index];
                          return Padding(
                            padding: const EdgeInsets.all(15),
                            child: Card(
                              color: const Color.fromRGBO(242, 255, 244, 1),
                              elevation: 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    '${cologne['image']}',
                                    height: 100,
                                    width: 100,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(cologne['name'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                        textAlign: TextAlign.center),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${cologne['brand']}',
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'R${cologne['price']}',
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 33, 33, 33),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.add_shopping_cart,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                                onPressed: () async {
                                                  String id = FirebaseFirestore
                                                      .instance
                                                      .collection('Cart')
                                                      .doc()
                                                      .id;
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Cart')
                                                      .doc(id)
                                                      .set(
                                                    {
                                                      "name": cologne['name'],
                                                      "brand": cologne['brand'],
                                                      "price": cologne['price'],
                                                      "email": value.userEmail,
                                                      "image": cologne['image'],
                                                      "id": id
                                                    },
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          "Item added to cart"),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
