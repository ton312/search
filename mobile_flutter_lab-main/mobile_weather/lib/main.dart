import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'cont.dart';
import 'settings.dart';
import 'search.dart';
import 'forecast.dart';
import 'favorites.dart';
import 'about.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]); //убрать верхню настройку
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 2014;
  int _degree = 30;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  void _incrementCounter() {
    setState(() {
      _counter++;
      _degree += _degree;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.lightBlue,
        drawer: Drawer(
          child: Column(
// Column
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 30, left: 20, bottom: 20),
                child: Text(
                  'Weather App',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Настройки'),
                subtitle: null,
                enabled: true,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Settings()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite_outline),
                title: const Text('Избранное'),
                subtitle: null,
                enabled: true,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Favor()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('О приложении'),
                subtitle: null,
                enabled: true,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const About()));
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background2.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 46.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '10 \u00B0C',
                    style: TextStyle(
                        fontSize: 72.0,
                        fontFamily: 'Roboto',
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 130.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '23 сент. 2021',
                    style: TextStyle(
                        fontSize: 22.0,
                        fontFamily: 'Roboto',
                        color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 42, left: 20),
              child: MaterialButton(
                color: Colors.blueAccent,
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                child: const Icon(
                  Icons.dehaze,
                  color: Colors.white,
                ),
                shape: const CircleBorder(),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 42, left: 340),
              child: MaterialButton(
                color: Colors.blueAccent,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPage())),
                child: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                ),
                shape: const CircleBorder(),
              ),
            ),
            SlidingUpPanel(
              minHeight: 230,
              maxHeight: 350,
              panel: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                              width: 80,
                              height: 3.3,
                              margin: const EdgeInsets.only(top: 10),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 180.0,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            semanticChildCount: 4,
                            children: const [
                              Conte(time: '06:00', temper: '10 \u00B0C'),
                              Conte(time: '12:00', temper: '10 \u00B0C'),
                              Conte(time: '18:00', temper: '10 \u00B0C'),
                              Conte(time: '00:00', temper: '10 \u00B0C'),
                            ]),
                      ),
                      OutlinedButton(
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const WeekPage())),
                        child: const Text('Прогноз на неделю'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
