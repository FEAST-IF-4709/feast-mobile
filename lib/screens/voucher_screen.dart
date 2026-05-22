import 'package:flutter/material.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  String selectedBrand = "Select Brand";

  final List<Map<String, dynamic>> vouchers = [
    {
      "brand": "Pizza House",
      "price": "Rp100.000",
      "min": "minimum spend Rp300.000",
      "image":
      "https://images.unsplash.com/photo-1513104890138-7c749659a591",
      "exp" : 7
    },
    {
      "brand": "Sushi Restaurant",
      "price": "Rp75.000",
      "min": "minimum spend Rp500.000",
      "image":
      "https://images.unsplash.com/photo-1579871494447-9811cf80d66c",
      "exp": 7,
    },
    {
      "brand": "Aldi's Burger",
      "price": "Rp100.000",
      "min": "minimum spend Rp300.000",
      "image":
      "https://images.unsplash.com/photo-1568901346375-23c9450c58cd",
      "exp": 7,
    },
    {
      "brand": "Piece of Cake",
      "price": "Rp30.000",
      "min": "minimum spend Rp100.000",
      "image":
      "https://images.unsplash.com/photo-1551024506-0bccd828d307",
      "exp": 10,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F4F1),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
          ),
          child: Column(
            children: [
              SizedBox(height: width * 0.04),

              // HEADER
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: width * 0.06,
                    ),
                  ),

                  Text(
                    "Voucher (20)",
                    style: TextStyle(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.deepOrange,
                    size: width * 0.065,
                  ),
                ],
              ),

              SizedBox(height: width * 0.06),

              // DROPDOWN + INPUT
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.03,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(
                          width * 0.025,
                        ),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),

                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedBrand,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: width * 0.06,
                          ),
                          isExpanded: true,

                          style: TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.038,
                          ),

                          items: [
                            "Select Brand",
                            "Sushi Restaurant",
                            "Pizza House",
                            "Aldi's Burger",
                            "Piece of Cake",
                          ].map((String value) {
                            return DropdownMenuItem(
                              value: value,

                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: width * 0.022,
                                    backgroundColor:
                                    Colors.orange.shade100,
                                    child: Icon(
                                      Icons.restaurant,
                                      size: width * 0.03,
                                      color: Colors.orange,
                                    ),
                                  ),

                                  SizedBox(
                                    width: width * 0.02,
                                  ),

                                  Expanded(
                                    child: Text(
                                      value,
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),

                          onChanged: (value) {
                            setState(() {
                              selectedBrand = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: width * 0.03),

                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(
                          width * 0.025,
                        ),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: TextField(
                        style: TextStyle(
                          fontSize: width * 0.038,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Voucher Code",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: width * 0.038,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: width * 0.05),

              // LIST
              Expanded(
                child: ListView.builder(
                  itemCount: vouchers.length,
                  itemBuilder: (context, index) {
                    final item = vouchers[index];

                    return Container(
                      margin: EdgeInsets.only(
                        bottom: width * 0.04,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(
                          width * 0.04,
                        ),
                        border: Border.all(
                          color: const Color(0xFFF0E2D8),
                        ),
                      ),

                      child: Row(
                        children: [
                          // IMAGE
                          ClipRRect(
                            borderRadius:
                            BorderRadius.only(
                              topLeft: Radius.circular(
                                width * 0.04,
                              ),
                              bottomLeft:
                              Radius.circular(
                                width * 0.04,
                              ),
                            ),

                            child: Image.network(
                              item["image"],
                              width: width * 0.36,
                              height: width * 0.45,
                              fit: BoxFit.cover,
                            ),
                          ),

                          // CONTENT
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(
                                width * 0.03,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Container(
                                        padding:
                                        EdgeInsets.symmetric(
                                          horizontal:
                                          width *
                                              0.025,
                                          vertical:
                                          width *
                                              0.008,
                                        ),
                                        decoration:
                                        BoxDecoration(
                                          color: const Color(
                                            0xFFE99000,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(
                                            width * 0.02,
                                          ),
                                        ),
                                        child: Text(
                                          "FEAST",
                                          style:
                                          TextStyle(
                                            color:
                                            Colors
                                                .white,
                                            fontSize:
                                            width *
                                                0.025,
                                          ),
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          Icon(
                                            Icons
                                                .calendar_today_outlined,
                                            size:
                                            width *
                                                0.03,
                                            color:
                                            Colors
                                                .grey,
                                          ),

                                          SizedBox(
                                            width:
                                            width *
                                                0.01,
                                          ),

                                          Text(
                                            "Valid until ${item["exp"]} days",
                                            style:
                                            TextStyle(
                                              fontSize:
                                              width *
                                                  0.03,
                                              color:
                                              Colors
                                                  .grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height:
                                    width * 0.025,
                                  ),

                                  Text(
                                    item["brand"],
                                    style: TextStyle(
                                      fontSize:
                                      width * 0.05,
                                      fontWeight:
                                      FontWeight.w500,
                                    ),
                                  ),

                                  Text(
                                    item["price"],
                                    style: TextStyle(
                                      fontSize:
                                      width * 0.055,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(
                                    height:
                                    width * 0.01,
                                  ),

                                  Text(
                                    item["min"],
                                    style: TextStyle(
                                      fontSize:
                                      width * 0.03,
                                      color: Colors.grey,
                                    ),
                                  ),

                                  SizedBox(
                                    height:
                                    width * 0.025,
                                  ),

                                  Align(
                                    alignment:
                                    Alignment
                                        .bottomRight,
                                    child: Container(
                                      padding:
                                      EdgeInsets.symmetric(
                                        horizontal:
                                        width *
                                            0.045,
                                        vertical:
                                        width *
                                            0.025,
                                      ),
                                      decoration:
                                      BoxDecoration(
                                        color:
                                        const Color(
                                          0xFF9A5300,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(
                                          width * 0.025,
                                        ),
                                      ),
                                      child: Text(
                                        "USE",
                                        style:
                                        TextStyle(
                                          color: Colors
                                              .white,
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize:
                                          width *
                                              0.032,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}