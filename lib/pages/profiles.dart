import 'package:flutter/material.dart';
import '../core/app_colors.dart';


class ProfilePage extends StatelessWidget {
  final String username;

  const ProfilePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text("Profile"),
              ),
              Icon(Icons.notifications),
            ],
          )
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
        ),
        child: SingleChildScrollView(
          child: Container(

              decoration: BoxDecoration(
                  color: Colors.white
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(12),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(99)
                          ),
                        ),
                        SizedBox(width: 12,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(username, style: TextStyle(fontWeight: FontWeight(600), fontSize: 20,)),
                            Text("user@email.com")
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
          ),
        ),
      )
    );
  }
}
