
import 'dart:convert';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:developer' as dev;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _focus = FocusNode();
  final _searchController = TextEditingController();

  Future<List<Result>> cityList = Future.value([]);

  @override
  void initState() {
    super.initState();
    _focus.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchCities() {
    if (_searchController.text.isEmpty) {
      return;
    }

    setState(() {
      cityList = searchCities(_searchController.text, 20);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: TextField(
          focusNode: _focus,
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
        future: cityList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            dev.log('Error: ${snapshot.error}');
            return const Center(child: Text('Не удалось получить результаты'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var item = snapshot.data![index];
              //var isFavorite = context.read<WeatherModel>().favoriteCities.contains(item.city);

              return GestureDetector(
                child: ListTile(
                  title: Text('${item.city} - ${item.country}'),
                  //trailing: Icon(isFavorite ? Icons.star : Icons.star_border),
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
        },
      ),
    );
  }
}


class Result {
  String city;
  String country;

  Result(this.city, this.country);

  @override
  bool operator==(o) => o is Result && city == o.city && country == o.country;

  @override
  int get hashCode => city.hashCode ^ country.hashCode;

}

Future<List<Result>> searchCities(String query, int maxRows) async {
  var url = Uri.http('api.geonames.org', '/searchJSON', {
    'q': query,
    'maxRows': maxRows.toString(),
    'lang': 'ru',
    'fuzzy': '1',
    'username': dotenv.env['GEONAMES_KEY'],
  });

  http.Response resp = await http.get(url);
  var json = jsonDecode(resp.body);

  if (resp.statusCode != 200) {
    throw Exception(json['status']['message']);
  }

  return (json['geonames'] as List)
      .where((geoname) => geoname['countryName'] != null)
      .map((geoname) => Result(geoname['name'], geoname['countryName']))
      .toSet()
      .toList();
}