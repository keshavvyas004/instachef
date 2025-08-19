import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'recipe_data.dart';
import 'recipe_model.dart';

class RecipePostScreen extends StatefulWidget {
  const RecipePostScreen({super.key});

  @override
  State<RecipePostScreen> createState() => _RecipePostScreenState();
}

class _RecipePostScreenState extends State<RecipePostScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> _mediaFiles = [];

  final List<String> _ingredients = [];
  final List<String> _steps = [];
  final List<String> _tags = []; // ✅ Tags list

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _stepController = TextEditingController();
  final TextEditingController _tagController =
      TextEditingController(); // ✅ Tag input

  Future<void> _pickMedia() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _mediaFiles.add(File(pickedFile.path));
      });
    }
  }

  void _addIngredient() {
    final ingredient = _ingredientController.text.trim();
    if (ingredient.isNotEmpty) {
      setState(() {
        _ingredients.add(ingredient);
        _ingredientController.clear();
      });
    }
  }

  void _addStep() {
    final step = _stepController.text.trim();
    if (step.isNotEmpty) {
      setState(() {
        _steps.add(step);
        _stepController.clear();
      });
    }
  }

  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty) {
      setState(() {
        _tags.add(tag.startsWith("#") ? tag : "#$tag"); // ✅ Auto add #
        _tagController.clear();
      });
    }
  }

  void _postRecipe() {
    if (_mediaFiles.isEmpty ||
        _steps.isEmpty ||
        _titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please add a title, at least 1 image and steps"),
        ),
      );
      return;
    }

    final recipe = Recipe(
      title: _titleController.text.trim(),
      images: List.from(_mediaFiles),
      ingredients: List.from(_ingredients),
      steps: List.from(_steps),
      tags: List.from(_tags), // ✅ Save tags as list
    );

    RecipeData.recipes.add(recipe);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Recipe Posted!")));

    Navigator.pushReplacementNamed(context, 'home');
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

              // ✅ Recipe Title
              Text(
                "Recipe Title",
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.title, color: Colors.black),
                  hintText: "Enter recipe title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // ✅ Upload Multiple Images
              Text(
                "Upload Images",
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
              const SizedBox(height: 10),

              InkWell(
                onTap: _pickMedia,
                child: Container(
                  height: 100,
                  width: double.infinity,
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

              // ✅ Ingredients
              Text(
                "Ingredients",
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _ingredientController,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _addIngredient(), // ✅ Press Enter
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
                        label: Text(
                          ingredient,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.transparent,
                        shape: const StadiumBorder(
                          side: BorderSide(color: Colors.white),
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

              // ✅ Steps
              Text(
                "Steps",
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _stepController,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _addStep(), // ✅ Press Enter
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.format_list_numbered,
                          color: Colors.black,
                        ),
                        hintText: "Add a step",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.white),
                    onPressed: _addStep,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _steps.asMap().entries.map((entry) {
                  int index = entry.key;
                  String step = entry.value;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: orange,
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    title: Text(
                      step,
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _steps.removeAt(index);
                        });
                      },
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // ✅ Tags
              Text(
                "Tags",
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _tagController,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _addTag(), // ✅ Press Enter
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.tag, color: Colors.black),
                        hintText: "Add a tag (e.g., vegan, dessert)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.white),
                    onPressed: _addTag,
                  ),
                ],
              ),
              Wrap(
                spacing: 8,
                children: _tags
                    .map(
                      (tag) => Chip(
                        label: Text(
                          tag,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.transparent,
                        shape: const StadiumBorder(
                          side: BorderSide(color: Colors.white),
                        ),
                        deleteIcon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onDeleted: () {
                          setState(() {
                            _tags.remove(tag);
                          });
                        },
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 30),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    minimumSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _postRecipe,
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
