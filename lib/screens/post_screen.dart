import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_box, size: 100, color: Colors.purple),
          Text('New Post Screen', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}