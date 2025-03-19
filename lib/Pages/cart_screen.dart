import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cologne_store_mobile_app/Provider/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final firestoreOrders = FirebaseFirestore.instance.collection("Orders");

  final firstNameController = TextEditingController();

  final addressController = TextEditingController();

  final cardNumberController = TextEditingController();

  final expirationDateController = TextEditingController();

  final cvvController = TextEditingController();

  List<String> paymentMethods = ["Cash on delivery", "Online"];

  String payment = "Online";

  String? selectedBank;

  final formKey = GlobalKey<FormState>();

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 102, 182, 116),
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: Consumer<EmailProvider>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Checkout'),
                  content: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(1),
                            child: TextFormField(
                              controller: firstNameController,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please specify who this delivery is for";
                                } else {
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                labelText: "Delivery for",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1),
                            child: TextFormField(
                              maxLines: 5,
                              controller: addressController,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please specify the delivery location";
                                } else {
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                labelText: "Delivery to",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1),
                            child: Row(
                              children: [
                                const Text(
                                  'Payment:',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 5,
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
                                        value: valueItem,
                                        child: Text(valueItem));
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          context
                              .read<EmailProvider>()
                              .getUserFirstName(firstNameController.text);
                          context
                              .read<EmailProvider>()
                              .getUserAddress(addressController.text);

                          if (payment == "Cash on delivery") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Checkout successful. Click on items you wish to add to your order."),
                              ),
                            );

                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Payment Information'),
                                content: SingleChildScrollView(
                                  child: Form(
                                    key: key,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        DropdownButtonFormField<String>(
                                          decoration: const InputDecoration(
                                            labelText: 'Select Bank',
                                            border: OutlineInputBorder(),
                                          ),
                                          value: selectedBank,
                                          items: const [
                                            DropdownMenuItem(
                                              value: 'ABSA',
                                              child: Text('ABSA'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'Capitec',
                                              child: Text('Capitec Bank'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'FNB',
                                              child: Text('FNB'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'Nedbank',
                                              child: Text('Nedbank'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'Standard Bank',
                                              child: Text('Standard Bank'),
                                            ),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              selectedBank = value;
                                            });
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          controller: cardNumberController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter your card number";
                                            } else if (value.length < 16 ||
                                                value.length > 16) {
                                              return "Card number should be 16 digits";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: const InputDecoration(
                                            labelText: 'Card Number',
                                            hintText: '1234 5678 9012 3456',
                                            border: OutlineInputBorder(),
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller:
                                                    expirationDateController,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter your card expiration date";
                                                  } else if (value.length < 5 ||
                                                      value.length > 5) {
                                                    return "Expiration date should be 4 digits";
                                                  } else if (!value
                                                      .contains('/')) {
                                                    return "Date should be seperate by a /";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Expiration Date',
                                                  hintText: 'MM/YY',
                                                  border: OutlineInputBorder(),
                                                ),
                                                keyboardType:
                                                    TextInputType.datetime,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: TextFormField(
                                                controller: cvvController,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter your card CVV";
                                                  } else if (value.length < 3 ||
                                                      value.length > 3) {
                                                    return "Card cvv should be 3 digits";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'CVV',
                                                  hintText: '123',
                                                  border: OutlineInputBorder(),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                obscureText: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (key.currentState!.validate()) {
                                              context
                                                  .read<EmailProvider>()
                                                  .getUserCardNumber(
                                                      cardNumberController
                                                          .text);
                                              context
                                                  .read<EmailProvider>()
                                                  .getUserExpirationDate(
                                                      expirationDateController
                                                          .text);
                                              context
                                                  .read<EmailProvider>()
                                                  .getUserCvv(
                                                      cvvController.text);

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Checkout successful. Click on items you wish to add to your order."),
                                                ),
                                              );

                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: const Icon(
                                            Icons.thumb_up_alt_outlined,
                                            color: Colors.lightGreen,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              );
            },
            color: const Color.fromARGB(255, 41, 90, 50),
            child: const Text(
              "Checkout",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: const Color.fromARGB(255, 41, 90, 50),
                            elevation: 10,
                            child: ListTile(
                              enabled: true,
                              onTap: () async {
                                final now = DateTime.now();
                                var time = DateTime(now.year, now.month,
                                        now.day, now.hour, now.minute)
                                    .toString();
                                String id = FirebaseFirestore.instance
                                    .collection('Orders')
                                    .doc()
                                    .id;
                                if (value.userFirstName.isEmpty ||
                                    value.userAddress.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("ok"),
                                        ),
                                      ],
                                      title: const Text("Checkout incomplete!"),
                                      contentPadding: const EdgeInsets.all(15),
                                      content: const Text(
                                          "Please fill out checkout information before placing order."),
                                    ),
                                  );
                                } else {
                                  await FirebaseFirestore.instance
                                      .collection('Orders')
                                      .doc(id)
                                      .set(
                                    {
                                      "first name": value.userFirstName,
                                      "address": value.userAddress,
                                      "payment method": payment,
                                      "bank": selectedBank,
                                      "card number": value.userCardNumber,
                                      "expiration date":
                                          value.userExpirationDate,
                                      "cvv": value.userCvv,
                                      "name": cologne['name'],
                                      "brand": cologne['brand'],
                                      "price": cologne['price'],
                                      "email": value.userEmail,
                                      "image": cologne['image'],
                                      "date": time,
                                      "id": id
                                    },
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Order succesful!"),
                                    ),
                                  );
                                }
                                String cologneId = cologne['id'];
                                await FirebaseFirestore.instance
                                    .collection('Cart')
                                    .doc(cologneId)
                                    .delete();
                              },
                              leading: Image.network('${cologne['image']}',
                                  height: 100, width: 100),
                              title: Text(cologne['name'],
                                  style: const TextStyle(color: Colors.white)),
                              subtitle: Text(
                                  '${cologne['brand']} \nR${cologne['price']}',
                                  style: const TextStyle(color: Colors.white)),
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
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
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
