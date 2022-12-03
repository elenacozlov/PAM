import 'package:flutter/material.dart';
import 'package:lab3/firstpage.dart';
import 'dart:io';

class Results extends StatelessWidget {
  var data;

  Results({super.key});

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 318,
              width: 342,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFF0F0F0)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Correct Answers",
                            style: TextStyle(
                              color: Color(0xFF7B7B7B),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              height: 0.6,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Completed In",
                            style: TextStyle(
                              color: Color(0xFF7B7B7B),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              height: 0.6,
                            ),
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${data["right"].toString()} / ${data["total"].toString()}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 0.6,
                        ),
                      ),
                      Text(
                        "${data["duration"].toString()} seconds",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 0.6,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            minimumSize: const Size(280, 46),
                          ),
                          onPressed: () {
                            exit(0);
                          },
                          child: const Text(
                            "Leave",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 0.7,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'SF Pro Text',
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            minimumSize: const Size(280, 46),
                          ),
                          onPressed: () {
                            Navigator.popUntil(
                                context, ModalRoute.withName('/'));
                          },
                          child: const Text(
                            "New Game",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 0.7,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'SF Pro Text',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
