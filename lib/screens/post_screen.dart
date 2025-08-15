import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class RecipePostScreen extends StatefulWidget {
  const RecipePostScreen({super.key});

  @override
  State<RecipePostScreen> createState() => _RecipePostScreenState();
}

class _RecipePostScreenState extends State<RecipePostScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> _mediaFiles = [];
  final List<String> _ingredients = [];
  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _recipeController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();

  // Pick an image
  Future<void> _pickMedia() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _mediaFiles.add(File(pickedFile.path));
      });
    }
  }

  // Add ingredient
  void _addIngredient() {
    final ingredient = _ingredientController.text.trim();
    if (ingredient.isNotEmpty) {
      setState(() {
        _ingredients.add(ingredient);
        _ingredientController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkBlue = const Color.fromRGBO(15, 29, 37, 1);
    final orange = const Color.fromRGBO(247, 158, 27, 1);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: 20,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: darkBlue,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Center(
                child: Text(
                  "Post Recipe",
                  style: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 1️⃣ Upload Media
              Text(
                "Upload Images / Videos",
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),

              if (_mediaFiles.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _mediaFiles
                      .map(
                        (file) => Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                file,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _mediaFiles.remove(file);
                                  });
                                },
                                child: const CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.close,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              SizedBox(height: 10),
              // Upload Button
              InkWell(
                onTap: _pickMedia,
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.10,
                    right: MediaQuery.of(context).size.width * 0.10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.add_a_photo,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 2️⃣ Ingredients
              Text(
                "Ingredients",
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _ingredientController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.restaurant, color: Colors.black),
                        hintText: "Add ingredient",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.white),
                    onPressed: _addIngredient,
                  ),
                ],
              ),
              Wrap(
                spacing: 8,
                children: _ingredients
                    .map(
                      (ingredient) => Chip(
                        backgroundColor: Colors.transparent,
                        shape: const StadiumBorder(
                          side: BorderSide(color: Colors.white),
                        ),
                        label: Text(
                          ingredient,
                          style: const TextStyle(color: Colors.white),
                        ),
                        deleteIcon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onDeleted: () {
                          setState(() {
                            _ingredients.remove(ingredient);
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),

              // 3️⃣ Full Recipe
              Text(
                "Full Recipe Details",
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _recipeController,
                maxLines: 10,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Write the recipe step-by-step...",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // 4️⃣ Tags
              Text(
                "Tags",
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _tagsController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.tag, color: Colors.black),
                  hintText: "Add tags using # (e.g., #vegan #dessert)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),

              // Post Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    minimumSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // TODO: Handle post action
                  },
                  child: const Text(
                    "Post",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
