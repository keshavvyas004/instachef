import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'recipe_model.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  recipe.title,
                  textAlign: TextAlign.center, // ⬅️ centered
                  style: GoogleFonts.robotoSlab(
                    fontSize: 40,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.80,
                width: MediaQuery.of(context).size.width * 0.80,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: recipe.images.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: Image.file(
                        recipe.images[index],
                        height: MediaQuery.of(context).size.width * 0.5,
                        width: MediaQuery.of(context).size.width * 0.5,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),

              if (recipe.images.length > 1)
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: recipe.images.length,
                    effect: const WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: Colors.black,
                      dotColor: Colors.grey,
                    ),
                  ),
                ),

              // 📌 Title
              const SizedBox(height: 20),

              // 🍴 Ingredients & Steps
              Container(
                width:
                    MediaQuery.of(context).size.width *
                    0.85, // ⬅️ centered card
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(15, 29, 37, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ingredients
                    Text(
                      "Ingredients",
                      style: GoogleFonts.robotoSlab(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (recipe.ingredients.isEmpty)
                      const Text(
                        "No ingredients added.",
                        style: TextStyle(color: Colors.white70),
                      )
                    else
                      ...recipe.ingredients.map(
                        (ingredient) => Text(
                          "- $ingredient",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),

                    const SizedBox(height: 20),

                    // Steps
                    Text(
                      "Steps",
                      style: GoogleFonts.robotoSlab(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (recipe.steps.isEmpty)
                      const Text(
                        "No steps available.",
                        style: TextStyle(color: Colors.white70),
                      )
                    else
                      ...recipe.steps.asMap().entries.map(
                        (entry) => Text(
                          "${entry.key + 1}. ${entry.value}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ✅ Back Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(247, 158, 27, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(200, 50),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Back",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
