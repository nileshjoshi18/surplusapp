import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final Map<String, dynamic> hotel;
  final Map<String, dynamic> deliveryDetails;

  const OrderConfirmationScreen({super.key, required this.hotel, required this.deliveryDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Order"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hotel Details
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(hotel['imageUrl'], height: 150, width: double.infinity, fit: BoxFit.cover),
                    const SizedBox(height: 10),
                    Text(hotel['hotelName'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("Address: ${hotel['address']}", style: TextStyle(color: Colors.grey[700])),
                    Text("Phone: ${hotel['phone']}", style: TextStyle(color: Colors.grey[700])),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Delivery Details
            const Text("Delivery Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Delivery Mode: ${deliveryDetails['deliveryMode']}", style: const TextStyle(fontSize: 16)),
                    Text("Contact: ${deliveryDetails['contactPerson']} (${deliveryDetails['phone']})", style: const TextStyle(fontSize: 16)),
                    if (deliveryDetails['deliveryMode'] == "Delivery")
                      Text("Address: ${deliveryDetails['deliveryAddress']}", style: const TextStyle(fontSize: 16)),
                    Text("Time: ${deliveryDetails['deliveryTime']}", style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const Spacer(),

            // Confirm Order Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {}, // No functionality for now
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Confirm Order"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
