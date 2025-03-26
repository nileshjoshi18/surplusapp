import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "http://10.0.2.2:5000"; // Change this to your backend URL

  // Fetch all food items
  static Future<List<dynamic>> fetchFoodItems() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/food-items'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to load food items");
      }
    } catch (e) {
      //      print("Error fetching food items: $e");
      return [];
    }
  }

  // Add a new food item
  static Future<bool> addFoodItem(Map<String, dynamic> foodItem) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/food-items'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(foodItem),
      );

      return response.statusCode == 201;
    } catch (e) {
      //      print("Error adding food item: $e");
      return false;
    }
  }

  // Delete a food item
  static Future<bool> deleteFoodItem(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/food-items/$id'));

      return response.statusCode == 200;
    } catch (e) {
      //      print("Error deleting food item: $e");
      return false;
    }
  }
}
