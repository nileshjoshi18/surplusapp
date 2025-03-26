class FoodItem {
  final String id;
  final String hotelName;
  final String foodItem;
  final String time;
  final String deliveryMode;
  final String quantity;
  final String imageUrl;

  FoodItem({
    required this.id,
    required this.hotelName,
    required this.foodItem,
    required this.time,
    required this.deliveryMode,
    required this.quantity,
    required this.imageUrl,
  });

  // Convert JSON to FoodItem object (for fetching data from API)
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['_id'] ?? '',
      hotelName: json['hotelName'] ?? '',
      foodItem: json['foodItem'] ?? '',
      time: json['time'] ?? '',
      deliveryMode: json['deliveryMode'] ?? '',
      quantity: json['quantity'] ?? '',
      imageUrl:
          json['imageUrl'] ??
          'https://via.placeholder.com/100', // Default image
    );
  }

  // Convert FoodItem object to JSON (for sending data to API)
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "hotelName": hotelName,
      "foodItem": foodItem,
      "time": time,
      "deliveryMode": deliveryMode,
      "quantity": quantity,
      "imageUrl": imageUrl,
    };
  }
}
