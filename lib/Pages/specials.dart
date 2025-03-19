import 'package:cologne_store_mobile_app/Pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Specials extends StatefulWidget {
  const Specials({super.key});

  @override
  State<Specials> createState() => _SpecialsState();
}

class _SpecialsState extends State<Specials> {
  final List<String> imageUrls = [
    "https://img.freepik.com/premium-vector/man-promoting-online-product-flat-illustration_44695-898.jpg",
    "https://i.pinimg.com/736x/7a/12/94/7a12944b4a789b132953a4cef74c47ad.jpg",
    // Add more promotion images if needed
  ];

  final List<Map<String, String>> specialProducts = [
    {
      'name': 'Elysian Essence',
      'brand': 'For Her',
      'oldPrice': 'R1800',
      'newPrice': 'R1500',
      'image': 'https://firebasestorage.googleapis.com/v0/b/cologne-store.appspot.com/o/images%2Fd4aaefdd-1099-4a4d-9977-f49ab79115a7.png?alt=media&token=1935173f-49b9-4034-ac42-862dbe5e1790',
    },
    {
      'name': 'Azeal',
      'brand': 'For Him',
      'oldPrice': 'R1800',
      'newPrice': 'R1300',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/cologne-store.appspot.com/o/images%2Fd2a20ba3-4c4e-45db-a654-e1c702ef2220.png?alt=media&token=dab5d7e9-fd5f-4a21-995c-12d617197a89',
    },
    {
      'name': 'Grape Rhuge',
      'brand': 'For Him',
      'oldPrice': 'R1600',
      'newPrice': 'R1000',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/cologne-store.appspot.com/o/images%2F36041a19-152c-4b15-ad4a-2be38a0829d6.png?alt=media&token=405a4ab9-1a67-4f9a-9a8f-f43d3fb95ffd',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 225, 225),
      appBar: AppBar(
        title: const Text('Specials'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 102, 182, 116),
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          color: const Color.fromARGB(255, 102, 182, 116),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainPage()),
            );
          },
          child: const Icon(Icons.sell),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel for Promotions
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CarouselSlider(
                items: imageUrls.map((imageUrl) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ).animate().fadeIn(duration: 1500.ms),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Specials Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: specialProducts.length,
                itemBuilder: (context, index) {
                  final product = specialProducts[index];
                  return Card(
                    elevation: 8,
                    shadowColor: Colors.grey.shade300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          product['image']!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ).animate().fadeIn(duration: 1000.ms),
                        const SizedBox(height: 10),
                        Text(
                          product['name']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(product['brand']!),
                        Text(
                          product['oldPrice']!,
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          product['newPrice']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
