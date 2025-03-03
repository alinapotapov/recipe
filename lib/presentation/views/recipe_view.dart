import 'package:flutter/material.dart';
import 'package:recipe_app/common/widgets/custom_card.dart';
import 'package:recipe_app/domain/entities/recipe/recipe.dart';

class RecipeView extends StatefulWidget {
  const RecipeView(this.recipe, {super.key});

  final Recipe recipe;

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            CustomCard(widget.recipe.instructions),
            Text(widget.recipe.name),
            Text(widget.recipe.category),
            Text(widget.recipe.cuisineType),
          ],
        ) /*Column(
          children: [
            Text(widget.recipe.name),
            Text(widget.recipe.category),
            Text(widget.recipe.cuisineType),
          ],
        )*/
        );
  }
}
