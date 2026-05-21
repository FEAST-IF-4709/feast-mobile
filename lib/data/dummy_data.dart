import 'package:flutter/material.dart';
import 'dart:math';

final random = Random();

bool randomPromo() {
  return random.nextBool();
}

final List<Map<String, dynamic>> restaurants = [
  {
    "name": "Pizza House",
    "logo":
    "https://images.unsplash.com/photo-1513104890138-7c749659a591",
    "color": const Color(0xFFFFCCB3),
    "icon": Icons.local_pizza,
    "rating": 4.8,
    "estimate": "20-30 min",

    "categories": [
      "Pizza",
      "Italian",
      "Fast Food",
    ],

    "menu": [
      {
        "promo": randomPromo(),
        "name": "Pepperoni Pizza",
        "description":
        "Classic pizza with pepperoni and melted mozzarella cheese.",
        "price": 120000,
        "image":
        "https://images.unsplash.com/photo-1513104890138-7c749659a591",
      },

      {
        "promo": randomPromo(),
        "name": "Cheese Pizza",
        "description":
        "Loaded with creamy mozzarella and rich tomato sauce.",
        "price": 95000,
        "image":
        "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38",
      },
    ],
  },

  {
    "name": "Sushi Restaurant",
    "logo":
    "https://images.unsplash.com/photo-1579871494447-9811cf80d66c",
    "color": const Color(0xFFFFE5E5),
    "icon": Icons.set_meal,
    "rating": 4.9,
    "estimate": "15-25 min",

    "categories": [
      "Sushi",
      "Japanese",
      "Seafood",
    ],

    "menu": [
      {
        "promo": randomPromo(),
        "name": "Salmon Sushi",
        "description":
        "Fresh salmon slices served with premium sushi rice.",
        "price": 75000,
        "image":
        "https://images.unsplash.com/photo-1579871494447-9811cf80d66c",
      },

      {
        "promo": randomPromo(),
        "name": "Tuna Roll",
        "description":
        "Soft tuna roll with crispy seaweed and sesame topping.",
        "price": 68000,
        "image":
        "https://images.unsplash.com/photo-1553621042-f6e147245754",
      },
    ],
  },

  {
    "name": "Aldi's Burger",
    "logo":
    "https://images.unsplash.com/photo-1568901346375-23c9450c58cd",
    "color": const Color(0xFFFFF000),
    "icon": Icons.fastfood,
    "rating": 4.7,
    "estimate": "10-20 min",

    "categories": [
      "Burger",
      "Fast Food",
      "American",
    ],

    "menu": [
      {
        "promo": randomPromo(),
        "name": "Double Cheeseburger",
        "description":
        "Juicy double beef patties with cheddar cheese and sauce.",
        "price": 89000,
        "image":
        "https://images.unsplash.com/photo-1568901346375-23c9450c58cd",
      },

      {
        "promo": randomPromo(),
        "name": "French Fries",
        "description":
        "Crispy golden fries served with savory seasoning.",
        "price": 35000,
        "image":
        "https://images.unsplash.com/photo-1573080496219-bb080dd4f877",
      },
    ],
  },

  {
    "name": "Piece of Cake",
    "logo":
    "https://images.unsplash.com/photo-1551024506-0bccd828d307",
    "color": const Color(0xFFFFB6C1),
    "icon": Icons.cake,
    "rating": 4.6,
    "estimate": "15-20 min",

    "categories": [
      "Dessert",
      "Cake",
      "Bakery",
    ],

    "menu": [
      {
        "promo": randomPromo(),
        "name": "Chocolate Cake",
        "description":
        "Soft chocolate sponge layered with rich cocoa cream.",
        "price": 55000,
        "image":
        "https://images.unsplash.com/photo-1551024506-0bccd828d307",
      },

      {
        "promo": randomPromo(),
        "name": "Strawberry Cake",
        "description":
        "Fresh strawberry cake with light whipped cream frosting.",
        "price": 60000,
        "image":
        "https://images.unsplash.com/photo-1464306076886-da185f6a9d05",
      },
    ],
  },

  {
    "name": "Coffee Corner",
    "logo":
    "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085",
    "color": const Color(0xFFD7CCC8),
    "icon": Icons.coffee,
    "rating": 4.5,
    "estimate": "5-15 min",

    "categories": [
      "Coffee",
      "Cafe",
      "Beverage",
    ],

    "menu": [
      {
        "promo": randomPromo(),
        "name": "Cappuccino",
        "description":
        "Espresso blended with steamed milk and foam.",
        "price": 40000,
        "image":
        "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085",
      },

      {
        "promo": randomPromo(),
        "name": "Latte",
        "description":
        "Smooth coffee latte with creamy milk texture.",
        "price": 45000,
        "image":
        "https://images.unsplash.com/photo-1509042239860-f550ce710b93",
      },
    ],
  },

  {
    "name": "Healthy Bowl",
    "logo":
    "https://images.unsplash.com/photo-1546069901-ba9599a7e63c",
    "color": const Color(0xFFC8E6C9),
    "icon": Icons.eco,
    "rating": 4.8,
    "estimate": "20-35 min",

    "categories": [
      "Healthy",
      "Salad",
      "Vegan",
    ],

    "menu": [
      {
        "promo": randomPromo(),
        "name": "Chicken Salad",
        "description":
        "Healthy salad bowl with grilled chicken and veggies.",
        "price": 65000,
        "image":
        "https://images.unsplash.com/photo-1546069901-ba9599a7e63c",
      },

      {
        "promo": randomPromo(),
        "name": "Avocado Bowl",
        "description":
        "Fresh avocado bowl packed with nutritious ingredients.",
        "price": 70000,
        "image":
        "https://images.unsplash.com/photo-1512621776951-a57141f2eefd",
      },
    ],
  },

  {
    "name": "Noodle House",
    "logo":
    "https://images.unsplash.com/photo-1569718212165-3a8278d5f624",
    "color": const Color(0xFFFFF9C4),
    "icon": Icons.ramen_dining,
    "rating": 4.7,
    "estimate": "15-30 min",

    "categories": [
      "Noodles",
      "Asian",
      "Spicy",
    ],

    "menu": [
      {
        "promo": randomPromo(),
        "name": "Chicken Ramen",
        "description":
        "Japanese ramen with tender chicken and rich broth.",
        "price": 58000,
        "image":
        "https://images.unsplash.com/photo-1569718212165-3a8278d5f624",
      },

      {
        "promo": randomPromo(),
        "name": "Spicy Noodles",
        "description":
        "Hot and spicy noodles with flavorful asian seasoning.",
        "price": 52000,
        "image":
        "https://images.unsplash.com/photo-1612929633738-8fe44f7ec841",
      },
    ],
  },

  {
    "name": "Ice Cream World",
    "logo":
    "https://images.unsplash.com/photo-1563805042-7684c019e1cb",
    "color": const Color(0xFFE1BEE7),
    "icon": Icons.icecream,
    "rating": 4.9,
    "estimate": "5-10 min",

    "categories": [
      "Ice Cream",
      "Dessert",
      "Sweet",
    ],

    "menu": [
      {
        "promo": randomPromo(),
        "name": "Vanilla Ice Cream",
        "description":
        "Creamy vanilla ice cream with smooth sweet flavor.",
        "price": 30000,
        "image":
        "https://images.unsplash.com/photo-1563805042-7684c019e1cb",
      },

      {
        "promo": randomPromo(),
        "name": "Chocolate Sundae",
        "description":
        "Chocolate sundae topped with syrup and crunchy bits.",
        "price": 35000,
        "image":
        "https://images.unsplash.com/photo-1570197788417-0e82375c9371",
      },
    ],
  },
];