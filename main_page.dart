/*import 'package:cologne_store_mobile_app/ApiHandler/api_handler.dart';
import 'package:cologne_store_mobile_app/Models/Cologne.dart';*/
//import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cologne_store_mobile_app/Pages/cart_screen.dart';
import 'package:cologne_store_mobile_app/Pages/login.dart';
import 'package:cologne_store_mobile_app/Pages/orders.dart';
import 'package:cologne_store_mobile_app/Pages/profile.dart';
import 'package:cologne_store_mobile_app/Provider/email_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MyMainPage();
}

class _MyMainPage extends State<MainPage> {
  List colognes = [];

  /*@override
  void initState() {
    fetchCologne();
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Colognes"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
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
            child: const Icon(Icons.shop_2),
          ),
          const SizedBox(width: 15),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          color: Colors.lightGreen,
          onPressed: () {
            /*Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Register()));*/
          },
          child: const Icon(Icons.home),
        ),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Profile"),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Profile(),
                    ),
                  );
                },
                child: const Icon(Icons.person)),
            const Divider(
              height: 100,
            ),
            const Text("Orders"),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Orders(),
                    ),
                  );
                },
                child: const Icon(Icons.attach_money)),
            const Divider(height: 100),
            const Text("Logout"),
            InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
                 Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Login()));
              },
              child: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
      body: Consumer<EmailProvider>(
        builder: (context, value, child) => Container(
          decoration: const BoxDecoration(),
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Colognes').snapshots(),
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
                              String id = FirebaseFirestore.instance
                                  .collection('Cart')
                                  .doc()
                                  .id;
                              await FirebaseFirestore.instance
                                  .collection('Cart')
                                  .doc(id)
                                  .set(
                                {
                                  "name": cologne['name'],
                                  "brand": cologne['brand'],
                                  "price": cologne['price'],
                                  "email": value.userEmail,
                                  "id": id
                                },
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Item added to cart"),
                                ),
                              );
                            },
                            child: const Icon(Icons.add_shopping_cart),
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

      /*ListView.builder(
          itemCount: colognes.length,
          itemBuilder: (context, index){
            final cologne = colognes[index] as Map;
          return ListTile(
            leading: Image.network('https://i.pinimg.com/originals/89/9a/30/899a3075798ce40e92ea4d4ccb418f4b.jpg'),
            title: Text(cologne['cologneName'],),
            subtitle: Text("${cologne['cologneMakerName']} \nR${cologne['price']}"),
            trailing: MaterialButton(onPressed: (){}, child: const Icon(Icons.shopping_cart),),
          );
        },),*/
    );
  }

  /*Future<void> fetchCologne () async {
    const url = 'https://10.0.2.2:7241/api/Colognes';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){
      final json = await jsonDecode(response.body);
      final result = json;
      setState(() {
        colognes = result;
      });
    }else{
      print("Error");
    }
  }*/
}
