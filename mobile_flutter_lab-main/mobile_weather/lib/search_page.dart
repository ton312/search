import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:untitled3/cont.dart';

class CitySearchPage extends StatefulWidget {
  const CitySearchPage({Key? key}) : super(key: key);

  @override
  _DataFromAPI createState() => _DataFromAPI();
}

class _DataFromAPI extends State<CitySearchPage> {
  final _searchFocus = FocusNode();
  final _searchController = TextEditingController();
  Future<List<Result>> list = Future.value([]);
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

    print((body['geonames'] as List)
        .where((geoname) => geoname['countryName'] != null)
        .map((geoname) => Result(geoname['name'], geoname['countryName']))
        .toSet()
        .toList());

    return (body['geonames'] as List)
        .where((geoname) => geoname['countryName'] != null)
        .map((geoname) => Result(geoname['name'], geoname['countryName']))
        .toSet()
        .toList();
    //return ResultWeather.fromJson(body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: TextField(
          focusNode: _searchFocus,
          controller: _searchController,
          onEditingComplete: _fetchCities,
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
      body: FutureBuilder<List<Result>>(
        future: list,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: Text("loading..."),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var item = snapshot.data![index];
                return GestureDetector(
                  child: ListTile(
                      title: Text('${item.city} - ${item.country}'),
                      trailing: Icon(Icons
                          .star_border) //Icon(isFavorite ? Icons.star : Icons.star_border),
                      ),
                  onTap: () {
                    // var weather = context.read<WeatherModel>();
                    // weather.currentCity = item.city;
                    // weather.addFavoriteCity(item.city);
                    // Navigator.pop(context);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ResultWeather {
  Result? city;
  double? temp;
  double? speed;
  int? pressure;

  ResultWeather.fromJson(Map<String, dynamic> json, Result) {
    city = Result;
    temp = json["main"]["temp"];
    speed = json["wind"]["speed"];
    pressure = json["main"]["pressure"];
  }
}

class Result {
  String city, country;

  Result(this.city, this.country);
}


// class _CitySearchPageState extends State<CitySearchPage> {
//   final _searchFocus = FocusNode();
//   final _searchController = TextEditingController();

//   Future<List<cities.SearchResult>> cityList = Future.value([]);

//   @override
//   void initState() {
//     super.initState();
//     _searchFocus.requestFocus();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _fetchCities() {
//     if (_searchController.text.isEmpty) {
//       return;
//     }

//     setState(() {
//       cityList = cities.searchCities(_searchController.text, 20);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: NeumorphicAppBar(
//         title: TextField(
//           focusNode: _searchFocus,
//           controller: _searchController,
//           onEditingComplete: _fetchCities,
//           style: const TextStyle(fontSize: 20),
//           decoration: const InputDecoration(
//             hintText: 'Введите город',
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: _fetchCities,
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<cities.SearchResult>>(
//         future: cityList,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             dev.log('Error: ${snapshot.error}');
//             return const Center(child: Text('Не удалось получить результаты'));
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           return ListView.separated(
//             separatorBuilder: (context, index) => const Divider(),
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               var item = snapshot.data![index];
//               var isFavorite = context
//                   .read<WeatherModel>()
//                   .favoriteCities
//                   .contains(item.city);

//               return GestureDetector(
//                 child: ListTile(
//                   title: Text('${item.city} - ${item.country}'),
//                   trailing: Icon(isFavorite ? Icons.star : Icons.star_border),
//                 ),
//                 onTap: () {
//                   var weather = context.read<WeatherModel>();
//                   weather.currentCity = item.city;
//                   weather.addFavoriteCity(item.city);
//                   Navigator.pop(context);
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }