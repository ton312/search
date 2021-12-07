import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'weather.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'cont.dart';
import 'settings_model.dart';
import 'page_settings.dart';
import 'forecast.dart';
import 'favorites.dart';
import 'about.dart';
import 'search_page.dart';

Result th = Result("Moskow", "Russia");
WeatherForecast favor = fetchWeatherForecast("Moskow") as WeatherForecast;

Future<void> main() async {
  //ServicesBinding.instance!.initInstances();
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
  await SettingsModel.initPrefs();
  runApp(MultiProvider(providers: [
    //ChangeNotifierProvider<WeatherModel>(create: (context) => WeatherModel()),
    ChangeNotifierProvider<SettingsModel>(create: (context) => SettingsModel()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const lightPrimary = Color(0xffe2ebff);
    const darkPrimary = Color(0xff0c1620);

    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      theme: const NeumorphicThemeData(
        baseColor: lightPrimary,
        variantColor: Color(0xffe1e9ff),
        accentColor: Color(0xff4b5f88),
        appBarTheme: NeumorphicAppBarThemeData(
          color: lightPrimary,
        ),
        textTheme: TextTheme(
          subtitle1: TextStyle(color: Color(0xff656565)),
          subtitle2: TextStyle(color: Colors.white),
        ),
      ),
      darkTheme: const NeumorphicThemeData(
        baseColor: darkPrimary,
        variantColor: Color(0xff0d172b),
        accentColor: Color(0xff0a1121),
        shadowLightColor: Color(0xFF828282),
        defaultTextColor: Colors.white,
        textTheme: TextTheme(
          subtitle1: TextStyle(color: Color(0xffe5e5e5)),
          subtitle2: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      materialTheme: ThemeData(
        scaffoldBackgroundColor: lightPrimary,
        backgroundColor: lightPrimary,
        cardColor: lightPrimary,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: lightPrimary,
        ),
      ),
      materialDarkTheme: ThemeData(
        scaffoldBackgroundColor: darkPrimary,
        primaryColor: Colors.white,
        backgroundColor: darkPrimary,
        cardColor: darkPrimary,
        brightness: Brightness.dark,
        cardTheme: const CardTheme(
          shadowColor: Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
      ),
      title: 'whether',
      routes: {
        '/': (context) => const MyHomePage(),
        '/settings': (context) => const SettingsPage(),
        '/about': (context) => const AboutPage(),
        '/favorite': (context) => FavorPage(),
        '/search': (context) => CitySearchPage(),
        //WeeklyForecastPage,
      },
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Navigator.pushNamed(context, "/settings");
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite_outline),
                title: const Text('Избранное'),
                subtitle: null,
                enabled: true,
                onTap: () {
                  Navigator.pushNamed(context, "/favorite");
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('О приложении'),
                subtitle: null,
                enabled: true,
                onTap: () {
                  Navigator.pushNamed(context, "/about");
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
                margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) =>
                            MainButton(
                              child: const Icon(Icons.menu, color: Colors.white),
                              onPressed: () => Scaffold.of(context).openDrawer(),
                            )
                      ),
                      MainButton(
                        child: const Icon(Icons.add, color: Colors.white),
                        onPressed: () => Navigator.pushNamed(context, "/search"),
                      ),
                    ]
                  )
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
                        onPressed: () => Navigator.pushNamed(context, "/search"),
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

class MainButton extends StatelessWidget {
  final Widget child;
  final NeumorphicButtonClickListener onPressed;

  // ignore: use_key_in_widget_constructors
  const MainButton({required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      style: const NeumorphicStyle(
        color: Colors.transparent,
        shadowLightColor: Colors.black87,
        lightSource: LightSource(0, 0),
        boxShape: NeumorphicBoxShape.circle(),
      ),
      child: child,
      onPressed: onPressed,
    );
  }
}
