import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon Comparador',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PokemonComparisonPage(),
    );
  }
}

class PokemonComparisonPage extends StatefulWidget {
  @override
  _PokemonComparisonPageState createState() => _PokemonComparisonPageState();
}

class _PokemonComparisonPageState extends State<PokemonComparisonPage> {
  bool isLoading = false;
  Map<String, dynamic>? pokemon1;
  Map<String, dynamic>? pokemon2;
  TextEditingController searchController1 = TextEditingController();
  TextEditingController searchController2 = TextEditingController();

  Future<void> fetchPokemon(String name, int index) async {
    setState(() {
      isLoading = true;
    });

    final url = 'https://pokeapi.co/api/v2/pokemon/$name';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Map<String, dynamic> pokemon = await fetchPokemonDetails(data['id']);
      setState(() {
        if (index == 1) {
          pokemon1 = pokemon;
        } else {
          pokemon2 = pokemon;
        }
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      showError('Pokémon no encontrado');
    }
  }

  Future<Map<String, dynamic>> fetchPokemonDetails(int id) async {
    final url = 'https://pokeapi.co/api/v2/pokemon/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Map<String, dynamic>> stats = (data['stats'] as List)
          .map((stat) => {
                'stat': stat['stat']['name'],
                'base_stat': stat['base_stat'],
              })
          .toList();

      List<Map<String, dynamic>> types = (data['types'] as List)
          .map((type) => {
                'type': type['type']['name'],
              })
          .toList();

      return {
        'name': data['name'],
        'image':
            data['sprites']['other']['official-artwork']['front_default'] ?? '',
        'stats': stats,
        'types': types,
        'totalStats':
            stats.fold<int>(0, (sum, stat) => sum + (stat['base_stat'] as int)),
      };
    } else {
      throw Exception('Datos no encontrados');
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  String comparePokemons() {
    if (pokemon1 == null || pokemon2 == null) {
      return 'Selecciona dos Pokémon para comparar';
    }

    final total1 = pokemon1!['totalStats'];
    final total2 = pokemon2!['totalStats'];

    if (total1 > total2) {
      return '${pokemon1!['name']} es el ganador con un total de $total1 puntos';
    } else if (total2 > total1) {
      return '${pokemon2!['name']} es el ganador con un total de $total2 puntos';
    } else {
      return 'Es un empate con $total1 puntos';
    }
  }

  Widget buildStatBar(String statName, int statValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          statName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Container(
          height: 10,
          width: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red,
                if (statValue > 100) Colors.orange else Colors.yellow,
                if (statValue > 150) Colors.green else Colors.blue
              ],
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 10,
              width: (statValue / 2).toDouble(),
              color: Colors.transparent,
            ),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget buildTypes(List<Map<String, dynamic>> types) {
    return Wrap(
      spacing: 8,
      children: types.map((type) {
        Color typeColor;
        switch (type['type']) {
          case 'fire':
            typeColor = Colors.red;
            break;
          case 'water':
            typeColor = Colors.blue;
            break;
          case 'grass':
            typeColor = Colors.green;
            break;
          case 'electric':
            typeColor = Colors.yellow;
            break;
          case 'psychic':
            typeColor = Colors.purple;
            break;
          case 'rock':
            typeColor = Colors.brown;
            break;
          case 'ground':
            typeColor = Colors.orange;
            break;
          case 'fairy':
            typeColor = Colors.pink;
            break;
          case 'fighting':
            typeColor = Colors.redAccent;
            break;
          case 'poison':
            typeColor = Colors.deepPurple;
            break;
          case 'bug':
            typeColor = Colors.lightGreen;
            break;
          case 'ghost':
            typeColor = Colors.indigo;
            break;
          case 'dragon':
            typeColor = Colors.indigoAccent;
            break;
          case 'dark':
            typeColor = Colors.black;
            break;
          case 'steel':
            typeColor = Colors.blueGrey;
            break;
          case 'ice':
            typeColor = Colors.cyan;
            break;
          case 'normal':
          default:
            typeColor = Colors.grey;
        }
        return Chip(
          label: Text(
            type['type'],
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: typeColor,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comparador de Pokémon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController1,
              decoration: InputDecoration(
                labelText: 'Primer Pokémon',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  fetchPokemon(value.toLowerCase(), 1);
                }
              },
            ),
            SizedBox(height: 10),
            TextField(
              controller: searchController2,
              decoration: InputDecoration(
                labelText: 'Segundo Pokémon',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  fetchPokemon(value.toLowerCase(), 2);
                }
              },
            ),
            SizedBox(height: 20),
            if (isLoading) CircularProgressIndicator(),
            if (!isLoading && pokemon1 != null && pokemon2 != null)
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (pokemon1 != null)
                          Column(
                            children: [
                              Image.network(
                                pokemon1!['image'],
                                width: 200,
                                height: 200,
                              ),
                              Text(pokemon1!['name']),
                              buildTypes(pokemon1!['types']),
                              SizedBox(height: 10),
                              ...pokemon1!['stats'].map((stat) {
                                return buildStatBar(
                                    stat['stat'], stat['base_stat']);
                              }).toList(),
                            ],
                          ),
                        if (pokemon2 != null)
                          Column(
                            children: [
                              Image.network(
                                pokemon2!['image'],
                                width: 200,
                                height: 200,
                              ),
                              Text(pokemon2!['name']),
                              buildTypes(pokemon2!['types']),
                              SizedBox(height: 10),
                              ...pokemon2!['stats'].map((stat) {
                                return buildStatBar(
                                    stat['stat'], stat['base_stat']);
                              }).toList(),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      comparePokemons(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
