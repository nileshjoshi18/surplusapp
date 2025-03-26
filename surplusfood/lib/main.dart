import 'package:flutter/material.dart';
import 'services/api_service.dart'; // Import API service

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const FoodListScreen(),
    );
  }
}

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({super.key});

  @override
  FoodListScreenState createState() => FoodListScreenState();
}

class FoodListScreenState extends State<FoodListScreen> {
  List<dynamic> foodItems = []; // List to store fetched food items

  @override
  void initState() {
    super.initState();
    loadFoodItems(); // Fetch data on startup
  }

  void loadFoodItems() async {
    final items = await ApiService.fetchFoodItems();
    setState(() {
      foodItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Food List
            Expanded(
              child:
                  foodItems.isEmpty
                      ? const Center(
                        child: CircularProgressIndicator(),
                      ) // Loading Indicator
                      : ListView.builder(
                        itemCount: foodItems.length,
                        itemBuilder: (context, index) {
                          var item = foodItems[index];
                          return FoodCard(item: item);
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final Map<String, dynamic> item;
  const FoodCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // Food Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item['imageUrl'],
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),

            // Food Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['hotelName'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    item['foodItem'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    item['time'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Delivery Mode & Quantity
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item['deliveryMode'],
                  style: const TextStyle(color: Colors.green),
                ),
                Text(
                  "Qty - ${item['quantity']}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
