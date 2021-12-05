import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Result> favourites = [];
class CitySearchPage extends StatefulWidget {
  const CitySearchPage({Key? key}) : super(key: key);

  @override
  _DataFromAPI createState() => _DataFromAPI();
}

class _DataFromAPI extends State<CitySearchPage> {
  final _searchFocus = FocusNode();
  final _searchController = TextEditingController();
  List<Result> list = [];

  void _fetchCities() {
    if (_searchController.text.isEmpty) {
      return;
    }

    setState(() async {
      //cityList = cities.searchCities(_searchController.text, 20);
      list = await getUserData(_searchController.text);
    });
  }

  Future getUserData(String query) async {
    //var resp = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$Result.cityName&appid=1369dd6b5ae78fc9952261ab9aa236b4&units=metric")); для
    var resp = await http.get(Uri.parse(
        "http://api.geonames.org/searchJSON?q=$query&maxRows=10&username=ton123"));
    var body = jsonDecode(resp.body);
    //List<Result> results = [];

    // for (var u in body) {
    //   //боди это мапа вот и жалуется
    //   if (u['countryName'] != null) {
    //     Result res = Result('name', u["countryName"]);
    //     results.add(res);
    //   }
    // }

    return (body['geonames'] as List)
        .where((geoname) => geoname['countryName'] != null)
        .map((geoname) => Result(geoname['name'], geoname['countryName']))
        .toSet()
        .toList();
    //return ResultWeather.fromJson(body);
  }

  chek(Result res){
    for (var element in favourites) {
      if (element.getIsFav() && res.city == element.city && res.country == element.country) {
        return true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: TextField(
          focusNode: _searchFocus,
          controller: _searchController,
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
            hintText: 'Введите город',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _fetchCities,
          ),
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: ListTile(
                title: Text('${list[index].city} - ${list[index].country}'),
                trailing: Icon(chek(list[index]) ? Icons.star : Icons.star_border),//Icon(isFavorite ? Icons.star : Icons.star_border),
            ),
            onTap: () {
              // var weather = context.read<WeatherModel>();
              // weather.currentCity = item.city;
              // weather.addFavoriteCity(item.city);
              if (list[index].isFavorite) {
                favourites.removeWhere((e) => e.city == list[index]);
              } else {
                favourites.add(list[index]);
              }
              //list[index].setIsFavor(true);
              list[index].isFavorite = !list[index].isFavorite;
              //Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}

class Result {
  String? city, country;
  double? temp;
  double? speed;
  int? pressure;
  bool isFavorite = false;
  Result(this.city, this.country);
  Result.fromJson(Map<String, dynamic> json) {
    temp = json["main"]["temp"];
    speed = json["wind"]["speed"];
    pressure = json["main"]["pressure"];
  }
  getIsFav(){
    if(isFavorite != null) return isFavorite;
  }
  getCity(){
    if(city != null) return city;
  }
}