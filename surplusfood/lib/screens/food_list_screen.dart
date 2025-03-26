import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({super.key}); // Added key parameter

  @override
  FoodListScreenState createState() => FoodListScreenState();
}

class FoodListScreenState extends State<FoodListScreen> {
  List foodItems = [];

  @override
  void initState() {
    super.initState();
    fetchFoodItems();
  }

  Future<void> fetchFoodItems() async {
    try {
      final response = await http
          .get(Uri.parse("http://10.0.2.2:5000/food-items"))
          .timeout(const Duration(seconds: 1));

      if (response.statusCode == 200) {
        setState(() {
          foodItems = json.decode(response.body);
        });
      }
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Dashboard"),
        actions: const [Icon(Icons.person_outline), SizedBox(width: 10)],
      ),
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
                      ? const Center(child: CircularProgressIndicator())
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
  const FoodCard({super.key, required this.item}); // Added key parameter

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
