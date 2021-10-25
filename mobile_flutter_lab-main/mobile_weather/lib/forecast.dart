import 'package:flutter/material.dart';
import 'main.dart';

class WeekPage extends StatelessWidget {
  const WeekPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 25),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pushNamed(context, "/"),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                const SizedBox(
                    child: Text(
                  'Прогноз на неделю',
                  style: TextStyle(
                      fontSize: 26.0,
                      fontFamily: 'Roboto',
                      color: Colors.black),
                ))
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 20, left: 20, bottom: 20, right: 10),
              child: OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, "/"),
                child: const Text('Вернуться на главную'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
