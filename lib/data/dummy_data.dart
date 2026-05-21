import 'package:flutter/material.dart';

final List<Map<String, dynamic>> restaurants = [
  {
    "name": "Pizza House",
    "logo":
    "https://images.unsplash.com/photo-1513104890138-7c749659a591",
    "color": const Color(0xFFFFCCB3),
    "icon": Icons.local_pizza,
    "menu": [
      {
        "name": "Pepperoni Pizza",
        "price": 120000,
        "image":
        "https://images.unsplash.com/photo-1513104890138-7c749659a591",
      },
      {
        "name": "Cheese Pizza",
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
    "menu": [
      {
        "name": "Salmon Sushi",
        "price": 75000,
        "image":
        "https://images.unsplash.com/photo-1579871494447-9811cf80d66c",
      },
      {
        "name": "Tuna Roll",
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
    "menu": [
      {
        "name": "Double Cheeseburger",
        "price": 89000,
        "image":
        "https://images.unsplash.com/photo-1568901346375-23c9450c58cd",
      },
      {
        "name": "French Fries",
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
    "menu": [
      {
        "name": "Chocolate Cake",
        "price": 55000,
        "image":
        "https://images.unsplash.com/photo-1551024506-0bccd828d307",
      },
      {
        "name": "Strawberry Cake",
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
    "menu": [
      {
        "name": "Cappuccino",
        "price": 40000,
        "image":
        "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085",
      },
      {
        "name": "Latte",
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
    "menu": [
      {
        "name": "Chicken Salad",
        "price": 65000,
        "image":
        "https://images.unsplash.com/photo-1546069901-ba9599a7e63c",
      },
      {
        "name": "Avocado Bowl",
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
    "menu": [
      {
        "name": "Chicken Ramen",
        "price": 58000,
        "image":
        "https://images.unsplash.com/photo-1569718212165-3a8278d5f624",
      },
      {
        "name": "Spicy Noodles",
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
    "menu": [
      {
        "name": "Vanilla Ice Cream",
        "price": 30000,
        "image":
        "https://images.unsplash.com/photo-1563805042-7684c019e1cb",
      },
      {
        "name": "Chocolate Sundae",
        "price": 35000,
        "image":
        "https://images.unsplash.com/photo-1570197788417-0e82375c9371",
      },
    ],
  },

  {
    "name": "BBQ Station",
    "logo":
    "https://images.unsplash.com/photo-1529193591184-b1d58069ecdd",
    "color": const Color(0xFFFFCCBC),
    "icon": Icons.outdoor_grill,
    "menu": [
      {
        "name": "BBQ Ribs",
        "price": 125000,
        "image":
        "https://images.unsplash.com/photo-1529193591184-b1d58069ecdd",
      },
      {
        "name": "Grilled Chicken",
        "price": 98000,
        "image":
        "https://images.unsplash.com/photo-1544025162-d76694265947",
      },
    ],
  },

  {
    "name": "Seafood Harbor",
    "logo":
    "https://images.unsplash.com/photo-1559847844-5315695dadae",
    "color": const Color(0xFFB3E5FC),
    "icon": Icons.set_meal,
    "menu": [
      {
        "name": "Grilled Salmon",
        "price": 145000,
        "image":
        "https://images.unsplash.com/photo-1559847844-5315695dadae",
      },
      {
        "name": "Shrimp Pasta",
        "price": 110000,
        "image":
        "https://images.unsplash.com/photo-1625943555419-56a2cb596640",
      },
    ],
  },
];