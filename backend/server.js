const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
require("dotenv").config();

const app = express();
app.use(cors());
app.use(express.json());

mongoose.connect("mongodb://127.0.0.1:27017/surplus_food_db")
  .then(() => console.log("MongoDB connected"))
  .catch(err => console.error("MongoDB connection error:", err));

const FoodSchema = new mongoose.Schema({
  hotelName: String,
  foodItem: String,
  time: String,
  deliveryMode: String,
  quantity: String,
  imageUrl: String
});

const Food = mongoose.model("Food", FoodSchema);

// API to Get All Food Items
app.get("/food-items", async (req, res) => {
  try {
    const foods = await Food.find();
    res.json(foods);
  } catch (err) {
    res.status(500).json({ error: "Error fetching food items" });
  }
});

// API to Add New Food Item
app.post("/food-items", async (req, res) => {
  try {
    const newFood = new Food(req.body);
    await newFood.save();
    res.json({ message: "Food Item Added!" });
  } catch (err) {
    res.status(500).json({ error: "Error adding food item" });
  }
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, "0.0.0.0", () => console.log(`Server running on port ${PORT}`));
