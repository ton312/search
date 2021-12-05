import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'search_page.dart';
class FavorPage extends StatelessWidget {
  const FavorPage({Key? key}) : super(key: key);
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
                  title: Text(favourites[index].getCity()),
                  trailing: NeumorphicButton(
                    style: NeumorphicStyle(
                      color: NeumorphicTheme.accentColor(context).withOpacity(0.2),
                    ),
                    child: const Icon(Icons.close),
                    onPressed: () {
                      //context.read<WeatherModel>().removeFavoriteCity(favorites[index]);
                    },
                  ),
                ),
              ),
              onTap: () {
                //context.read<WeatherModel>().currentCity = favorites[index];
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}