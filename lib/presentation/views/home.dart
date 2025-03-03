import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_app/common/widgets/async_search_anchor.dart';
import 'package:recipe_app/domain/entities/recipe/recipe.dart';
import 'package:recipe_app/presentation/views/recipe_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CategoryWidget(),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  "I would like to cook",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            const Flexible(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                    height: 50, // Adjust as needed
                    child: CustomAsyncSearchAnchor()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      'icon': Icons.egg,
      'label': 'Chicken',
      'color': Color.fromARGB(255, 185, 243, 187)
    },
    {
      'icon': Icons.set_meal,
      'label': 'Beef',
      'color': Color.fromARGB(255, 244, 241, 211)
    },
    {
      'icon': Icons.fiber_dvr_outlined,
      'label': 'Fish',
      'color': Colors.blue[100]
    },
    {
      'icon': Icons.account_circle,
      'label': 'Random',
      'color': Colors.pink[100]
    },
  ];
  Future<Map> fetchUsers() async {
    try {
      Response response =
          await Dio().get('https://www.themealdb.com/api/json/v1/1/random.php');
      return response.data["meals"][0];
    } catch (e) {
      print('Error fetching users: $e');
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: null,
          child: const Icon(Icons.menu),
        ),
        title: Text("Categories"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: categories.map((category) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (category['label'] == "Random") {
                      final recipe = await fetchUsers();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecipeView(Recipe(
                                id: '1',
                                ingredients: [],
                                name: recipe["strMeal"],
                                instructions: recipe["strMealThumb"],
                                cookTime: 100,
                                cuisineType: recipe["strArea"],
                                category: recipe["strCategory"]))),
                      );
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: category['color'],
                    radius: 40,
                    child: Icon(
                      category['icon'],
                      size: 40,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  category['label'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
