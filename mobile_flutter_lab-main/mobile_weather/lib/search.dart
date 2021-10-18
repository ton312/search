import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  //SearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return _Search;
  }
}

class _Search extends State<SearchPage> {
  bool _load = false;
  final _controller = TextEditingController();
  Icon search = Icon(Icons.search);
  Widget cusSearchVar = Text("Поиск...");

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
            onPressed: () {
              setState(() {
                if (search.icon == Icons.search) {
                  search = const Icon(Icons.cancel);
                  cusSearchVar = const TextField(
                    textInputAction: TextInputAction.go,
                    // decoration: InputDecorator(
                    //   border: InputBorder.none,
                    //   hintText: "Search Term",
                    // ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  );
                } else {
                  Icon search = Icon(
                    Icons.search,
                  );
                  Widget cusSearchVar = Text("Поиск...");
                }
              });
            },
            icon: search,
          )
        ],
        // bottom: PreferredSize(
        //   preferredSize: const Size(50, 50),
        //   child: Container(),
        // ),

        //elevation: 20.0,

        title: cusSearchVar,
      ),
    );
  }
}
