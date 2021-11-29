import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CitySearchPage extends StatefulWidget {
  const CitySearchPage({Key? key}) : super(key: key);

  @override
  _DataFromAPI createState() => _DataFromAPI();
}

class _DataFromAPI extends State<CitySearchPage> {
  final _searchFocus = FocusNode();
  final _searchController = TextEditingController();

  void _fetchCities() {
    if (_searchController.text.isEmpty) {
      return;
    }

    setState(() {
      //cityList = cities.searchCities(_searchController.text, 20);
      print("KOK");
    });
  }

  getUserData(String query, int maxRows) async {
    var resp = await http.get(Uri.http('api.geonames.org', '/searchJSON', {
      'q': query,
      'maxRows': maxRows.toString(),
      'lang': 'ru',
      'fuzzy': '1',
      'username': dotenv.env['GEONAMES_KEY'],
    }));
    var json = jsonDecode(resp.body);
    if (resp.statusCode != 200) {
      throw Exception(json['status']['message']);
    }
    List<Result> results = [];
    for (var u in json) {
      if (u['countryName'] != null) {
        Result res = Result('name', u["countryName"]);
        results.add(res);
      }
    }
    print(results.length);
    return results;
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
      body: Center(
        child: ElevatedButton(
          child: Text("klick"),
          onPressed: () {
            getUserData(_searchController.text, 10);
          },
        ),
      ),
    );
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