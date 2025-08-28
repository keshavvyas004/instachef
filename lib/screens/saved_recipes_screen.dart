import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'recipe_data.dart';
import 'RecipeDetailScreen.dart';

class SavedRecipesScreen extends StatelessWidget {
  const SavedRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final savedRecipes = RecipeData.recipes.where((r) => r.isSaved).toList();
    final Map<int, PageController> _controllers = {};

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Saved Recipes",
          style: GoogleFonts.cookie(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(15, 29, 37, 1),
      ),
      backgroundColor: const Color.fromRGBO(15, 29, 37, 1),
      body: savedRecipes.isEmpty
          ? const Center(
              child: Text(
                "No saved recipes yet",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: savedRecipes.length,
              itemBuilder: (context, index) {
                final recipe = savedRecipes[index];

                // Assign a PageController per recipe
                _controllers[index] =
                    _controllers[index] ?? PageController(initialPage: 0);

                return Card(
                  margin: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.white,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecipeDetailScreen(recipe: recipe),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ✅ Title before image
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 8.0,
                          ),
                          child: Center(
                            child: Text(
                              recipe.title,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoSlab(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(15, 29, 37, 1),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),

                        // ✅ Recipe image carousel
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 300,
                            child: PageView.builder(
                              controller: _controllers[index],
                              physics: const BouncingScrollPhysics(),
                              itemCount: recipe.images.length,
                              itemBuilder: (context, imgIndex) {
                                return Image.file(
                                  File(recipe.images[imgIndex].path),
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                  height: 300,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
