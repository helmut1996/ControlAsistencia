import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class Reloj extends StatefulWidget {
  @override
  _RelojState createState() => _RelojState();
}

class _RelojState extends State<Reloj> {
  String getSystemTime() {
    var now = new DateTime.now();
    return new DateFormat().add_jms().format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: SingleChildScrollView(
          child:
              TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
            return Text(
              "${getSystemTime()}",
              style: TextStyle(
                  color: Color(0xffefefef),
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
            );
          }),
        ),
      ),
    );
  }
}
