import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySearchScreen extends StatefulWidget {
  const MySearchScreen({super.key});

  @override
  State<MySearchScreen> createState() => _MySearchScreenState();
}

class _MySearchScreenState extends State<MySearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Placeholder list for recent searches
  final List<String> _recentSearches = [
    'Pasta',
    'Chicken Tikka Masala',
    'Pizza',
    'Salad',
  ];

  void _performSearch(String query) {
    // This is where you would implement your search logic.
    // For now, we'll just print the query.
    print('Searching for: $query');
    // You could also navigate to a results screen or update the UI here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(15, 29, 37, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              onSubmitted: _performSearch,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Search for recipes...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.black),
                  onPressed: () {
                    _searchController.clear();
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Recent Searches Section
            Text(
              'Recent Searches',
              style: GoogleFonts.cookie(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: _recentSearches.map((search) {
                return Chip(
                  label: Text(search, style: const TextStyle(color: Color.fromRGBO(15, 29, 37, 1))),
                  backgroundColor: const Color.fromRGBO(247, 158, 27, 1),
                  onDeleted: () {
                    setState(() {
                      _recentSearches.remove(search);
                    });
                  },
                  deleteIconColor: Colors.white,
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Divider(color: Color.fromRGBO(247, 158, 27, 1)),
            const SizedBox(height: 20),

            // Placeholder for search results
            Expanded(
              child: Center(
                child: Text(
                  'Search results will appear here...',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}