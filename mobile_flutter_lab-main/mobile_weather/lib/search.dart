import 'package:flutter/material.dart';
import 'main.dart';

class SearchPage extends StatelessWidget {
  final _controller = TextEditingController();
  Icon search = const Icon(
    Icons.search,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const MyHomePage(title: "Погода"))),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        actions: <Widget>[
          // InkWell(
          //   onTap: () {},
          //   child: const SizedBox(
          //     width: 200.0,
          //     child: Icon(
          //       Icons.search,
          //     ),
          //   ),
          // ),
          IconButton(
            onPressed: () {},
            icon: search,
          )
        ],
        // bottom: PreferredSize(
        //   preferredSize: const Size(50, 50),
        //   child: Container(),
        // ),

        //elevation: 20.0,

        title: const Text("APPPP"),
      ),
    );
  }
}
