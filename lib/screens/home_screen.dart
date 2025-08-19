import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'recipe_model.dart';
import 'recipe_data.dart';
import 'RecipeDetailScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _commentController = TextEditingController();

  // Store page controllers for each recipe
  final Map<int, PageController> _controllers = {};

  PageController _getController(int index) {
    return _controllers.putIfAbsent(index, () => PageController());
  }

  void _toggleLike(Recipe recipe) {
    setState(() {
      recipe.isLiked = !recipe.isLiked;
      recipe.likeCount += recipe.isLiked ? 1 : -1;
    });
  }

  void _addComment(Recipe recipe, String comment) {
    if (comment.trim().isEmpty) return;
    setState(() {
      recipe.comments.add(comment.trim());
    });
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final recipes = RecipeData.recipes;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(15, 29, 37, 1),
      body: recipes.isEmpty
          ? const Center(
              child: Text(
                "No recipes yet",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                final controller = _getController(index);

                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ✅ Recipe Images with PageView
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 300,
                          child: PageView.builder(
                            controller: controller,
                            physics:
                                const BouncingScrollPhysics(), // smooth scroll
                            itemCount: recipe.images.length,
                            itemBuilder: (context, imgIndex) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          RecipeDetailScreen(recipe: recipe),
                                    ),
                                  );
                                },
                                child: Image.file(
                                  recipe.images[imgIndex],
                                  fit: BoxFit.fitHeight,
                                  width: MediaQuery.of(context).size.width*0.5,
                                  height: MediaQuery.of(context).size.width*0.5,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // ✅ Dots Indicator
                      if (recipe.images.length > 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Center(
                            child: SmoothPageIndicator(
                              controller: controller,
                              count: recipe.images.length,
                              effect: const WormEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                activeDotColor: Colors.black,
                                dotColor: Colors.grey,
                              ),
                            ),
                          ),
                        ),

                      // Title
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          recipe.title,
                          style: GoogleFonts.cookie(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(15, 29, 37, 1),
                          ),
                        ),
                      ),

                      // ✅ Like + Comment Buttons
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              recipe.isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: recipe.isLiked ? Colors.red : Colors.black,
                            ),
                            onPressed: () => _toggleLike(recipe),
                          ),
                          Text("${recipe.likeCount}"),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: const Icon(
                              Icons.comment,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (_) => _buildCommentSheet(recipe),
                              );
                            },
                          ),
                          Text("${recipe.comments.length}"),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  // ✅ Bottom sheet for comments
  Widget _buildCommentSheet(Recipe recipe) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Comments",
              style: GoogleFonts.cookie(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(15, 29, 37, 1),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: recipe.comments.length,
                itemBuilder: (context, index) =>
                    ListTile(title: Text(recipe.comments[index])),
              ),
            ),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: "Add a comment...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _addComment(recipe, _commentController.text),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
