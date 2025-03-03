import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CustomAsyncSearchAnchor extends StatefulWidget {
  const CustomAsyncSearchAnchor({super.key});

  @override
  State<CustomAsyncSearchAnchor> createState() =>
      _CustomAsyncSearchAnchorState();
}

class _CustomAsyncSearchAnchorState extends State<CustomAsyncSearchAnchor> {
  final Map<String, bool> _checkedStates = {};

  late Iterable<Widget> _lastOptions = <Widget>[];

  bool isChecked = false;

  TextEditingController controller = TextEditingController();
  List meal = [];

  Future<List> _search(String query) async {
    await fetchUsers(query);
    return meal;
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(queryListener);
  }

  @override
  void dispose() {
    controller.dispose();
    meal = []; // Dispose to prevent memory leaks
    super.dispose();
  }

  Future<List> queryListener() async {
    return await _search(controller.text);
  }

  Future<List> fetchUsers(String text) async {
    Response response;

    try {
      meal = [];
      response = await Dio().get(
        'https://www.themealdb.com/api/json/v1/1/filter.php?',
        queryParameters: {
          'i': text,
        },
      );
      final List list = response.data["meals"];
      for (final item in list) {
        meal.add(item["strMeal"]);
      }
    } catch (e) {
      print('Error fetching users: $e');
      //return [];
    }
    return meal;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SearchAnchor(
        dividerColor: Colors.grey,
        isFullScreen: false,
        viewConstraints: const BoxConstraints(
          maxHeight: 400,
        ),
        viewShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        viewBackgroundColor: Colors.white,
        builder: (BuildContext context, controller) {
          return SearchBar(
            elevation: WidgetStateProperty.all(01),
            backgroundColor: WidgetStateProperty.all<Color>(
              Colors.white,
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            controller: controller,
            padding: const WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)),
            onTap: () {
              controller.openView();
            },
            leading: const Icon(Icons.search),
          );
        },
        suggestionsBuilder: (BuildContext context, controller) async {
          final options = (await _search(controller.text))?.toList();
          if (options == null) {
            return _lastOptions;
          }

          _lastOptions = List<ListTile>.generate(meal.length, (int index) {
            final String item = meal[index];
            return ListTile(
              title: Text(item),
              trailing: StatefulBuilder(
                builder: (BuildContext context,
                    void Function(void Function()) setState) {
                  return Checkbox(
                    value: _checkedStates[item] ?? false,
                    onChanged: (bool? value) {
                      setState(() {
                        _checkedStates[item] = value!;
                      });
                    },
                  );
                },
              ),
            );
          });
          return _lastOptions;
        },
      ),
    );
  }
}

// Mimics a remote API.
/*class _FakeAPI {
  static const List<String> _kOptions = <String>[
    'dr zimmer',
    'dr morgan',
    'dr rex',
  ];
  Future<Map> fetchUsers() async {
    try {
      Response response = await Dio().get(
        'https://www.themealdb.com/api/json/v1/1/filter.php?',
        queryParameters: {
          'i': 'egg',
        },
      );
    } catch (e) {
      print('Error fetching users: $e');
    }
    return {};
  }

   Future<Iterable<String>> search(String query) async {
    if (query == '') {
      return const Iterable<String>.empty();
    }
    await fetchUsers();
    return _kOptions.where((String option) {
      return option.contains(query.toLowerCase());
    });
  }
}*/


