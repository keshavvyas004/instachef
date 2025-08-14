import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String recipeTitle;
  final String recipeDescription;
  final List<String> ingredients;

  const RecipeDetailScreen({
    super.key,
    required this.recipeTitle,
    required this.recipeDescription,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(recipeDescription),
            const SizedBox(height: 24),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Display ingredients using a ListView or Column
            ...ingredients.map((ingredient) => Text('- $ingredient')).toList(),
          ],
        ),
      ),
    );
  }
}