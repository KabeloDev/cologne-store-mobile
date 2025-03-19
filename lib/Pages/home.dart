import 'package:cologne_store_mobile_app/Pages/login.dart';
import 'package:cologne_store_mobile_app/Pages/main_page.dart';
import 'package:cologne_store_mobile_app/Pages/orderDetails.dart';
import 'package:cologne_store_mobile_app/Pages/profile.dart';
import 'package:cologne_store_mobile_app/Pages/reviews.dart';
import 'package:cologne_store_mobile_app/Provider/email_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 225, 225),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: const Color.fromARGB(255, 65, 65, 65),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.clear_all_rounded,
              size: 40,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 102, 182, 116),
              minimumSize: const Size(420, 65),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MainPage()));
            },
            child: const Text(
              "Get Started",
              style: TextStyle(
                  color: Color.fromARGB(255, 233, 219, 186),
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            )),
      ),
      drawer: Consumer<EmailProvider>(
        builder: (context, value, child) => Drawer(
          backgroundColor: const Color.fromARGB(255, 102, 182, 116),
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text("Profile"),
                accountEmail: Text(value.userEmail),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://static.vecteezy.com/system/resources/previews/032/310/846/original/verified-account-icon-in-trendy-outline-style-isolated-on-white-background-verified-account-silhouette-symbol-for-your-website-design-logo-app-ui-illustration-eps10-free-vector.jpg'),
                ),
                decoration: const BoxDecoration(
                    color: const Color.fromARGB(255, 102, 182, 116)),
              ).animate().slideX(curve: Curves.easeInOut),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: const Text("Profile",
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Profile()));
                },
              ).animate().fade(duration: 800.ms).slideX(),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.attach_money, color: Colors.white),
                title:
                    const Text("Orders", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderDetails()));
                },
              ).animate().fade(duration: 800.ms).slideX(),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.library_books_outlined,
                    color: Colors.white),
                title: const Text("Reviews",
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Reviews()));
                },
              ).animate().fade(duration: 800.ms).slideX(),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
              ).animate().fade(duration: 800.ms).slideX(),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white54,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Montreal Odör",
                style: TextStyle(
                    fontSize: 50,
                    fontFamily: "Olivera",
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Animate(
                effects: const [FadeEffect(), ScaleEffect()],
                child: const Text(
                  'FOR HIM AND FOR HER',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
                    .animate()
                    .fade(duration: 1500.ms)
                    .slideY(curve: Curves.easeIn),
              ),
              const SizedBox(height: 20),
              const Text(
                'On route to becoming the #1 trusted fragnace supply.\nOur products dont just smell good, they make heads turn when you walk by.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              const Text(
                'Choose Unique, Choose Montreal Odör.',
                style: TextStyle(
                    fontStyle: FontStyle.italic, fontWeight: FontWeight.w800),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  "https://media.giphy.com/media/5n01MiDbS2oi61sE4X/giphy.gif?cid=ecf05e47nq28td2vgy51jbg5zx30u2ypsxfxvvjrknsrw96o&ep=v1_gifs_search&rid=giphy.gif&ct=g",
                ).animate().fade(duration: 2000.ms).scale(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
