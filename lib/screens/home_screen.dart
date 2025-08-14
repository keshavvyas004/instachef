import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instachef/screens/RecipeDetailScreen.dart';

// Dummy data for posts
final List<Map<String, dynamic>> posts = const [
  {
    'imageUrl': 'https://placehold.co/600x400/FF5733/000000?text=Recipe+1',
    'title': 'Spaghetti Carbonara',
    'description': 'A classic Italian pasta dish made with eggs, hard cheese, cured pork, and black pepper.',
    'ingredients': ['Spaghetti', 'Eggs', 'Pancetta', 'Pecorino cheese', 'Black pepper'],
  },
  {
    'imageUrl': 'https://placehold.co/600x400/33FF57/000000?text=Recipe+2',
    'title': 'Chicken Curry',
    'description': 'A flavorful and aromatic curry with tender chicken pieces in a rich, spiced sauce.',
    'ingredients': ['Chicken', 'Curry powder', 'Onion', 'Garlic', 'Coconut milk'],
  },
  {
    'imageUrl': 'https://placehold.co/600x400/33AFFF/000000?text=Recipe+3',
    'title': 'Chocolate Cake',
    'description': 'A rich and decadent chocolate cake, perfect for any celebration.',
    'ingredients': ['Flour', 'Sugar', 'Cocoa powder', 'Eggs', 'Milk', 'Oil', 'Baking powder'],
  },
  // Add more posts here...
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostCard(
          imageUrl: post['imageUrl'] as String,
          onImageTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailScreen(
                  recipeTitle: post['title'] as String,
                  recipeDescription: post['description'] as String,
                  ingredients: post['ingredients'] as List<String>,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class PostCard extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onImageTap;

  const PostCard({
    super.key,
    required this.imageUrl,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: onImageTap,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {
                        // Handle like action
                      },
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.comment_outlined),
                      onPressed: () {
                        // Handle comment action
                      },
                    ),
                  ],
                ),
                Text('Likes: 123', style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}