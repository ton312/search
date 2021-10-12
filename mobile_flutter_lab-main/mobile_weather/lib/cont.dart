import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Conte extends StatelessWidget {
  final String time;
  final String temper;

  const Conte({Key? key, this.time = '00:00', this.temper = '0'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        width: 70,
        decoration: const BoxDecoration(
          color: Color(0xFFDAE5EA),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        margin: const EdgeInsets.only(top: 20, left: 20, bottom: 20, right: 10),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                  fontSize: 16.0, fontFamily: 'Roboto', color: Colors.black),
            ),
            const Icon(Icons.cloud),
            Text(
              temper,
              style: const TextStyle(
                  fontSize: 16.0, fontFamily: 'Roboto', color: Colors.black),
            ),
          ],
        ));
  }
}
