import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthy_bites/Bottom_Bar/home_page.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/home.dart';

class SuccessfullyPage extends StatefulWidget {
  const SuccessfullyPage({super.key});

  @override
  State<SuccessfullyPage> createState() => _SuccessfullyPageState();
}

class _SuccessfullyPageState extends State<SuccessfullyPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_done_sharp,
                    size: 48,
                    color: Color_me.main,
                  ),
                  Text(
                    "Successfully Done Payment",
                    style: TextStyle(
                      color: Color_me.black,
                      fontSize: 22,
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color_me.main),
                      onPressed: () {
                        setState(() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        });
                      },
                      child: Text("হোম")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
