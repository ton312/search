import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled3/weather.dart';
import 'search_page.dart';
import 'main.dart';

class FavorPage extends StatefulWidget {

  @override
  State<FavorPage> createState() => _FavorPageState();
}

class _FavorPageState extends State<FavorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
          leading: IconButton(
            onPressed: () => Navigator.pushNamed(context, "/"),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
          title: const Text('Избранное')
      ),
      body: ListView.builder(
        itemCount: favourites.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Neumorphic(
                style: NeumorphicStyle(
                  color: NeumorphicTheme.variantColor(context),
                  depth: -5,
                ),
                child: ListTile(
                  title: Text(favourites[index].city),
                  trailing: NeumorphicButton(
                    style: NeumorphicStyle(
                      color: NeumorphicTheme.accentColor(context).withOpacity(0.2),
                    ),
                    child: const Icon(Icons.close),
                    onPressed: () async {
                      // ignore: unrelated_type_equality_checks
                      if(favor == favourites[index]) {
                        Result th = Result("Moskow", "Russia");
                        var l = await fetchWeatherForecast("Moskow");
                        WeatherForecast favor = l;
                      }
                      setState(()  {
                        favourites.removeWhere((element) => element == favourites[index]);
                      });
                    },
                  ),
                ),
              ),
              onTap: () async {
                var l = await fetchWeatherForecast(favourites[index].city);
                setState(()  {
                  th = favourites[index];
                  favor =  l;
                });
              },
            ),
          );
        },
      ),
    );
  }
}