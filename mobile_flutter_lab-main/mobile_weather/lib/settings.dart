import 'package:flutter/material.dart';
import 'main.dart';
class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          IconButton(
            onPressed: () =>  Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MyHomePage(title: "Погода"))),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
        ]
      )
    );
  }
}
