import 'dart:io'; // ✅ Needed for FileImage
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instachef/screens/login_screen.dart';
import 'recipe_data.dart';
import 'RecipeDetailScreen.dart';
import 'edit_profile_screen.dart';
import 'saved_recipes_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Text(
                    'Settings & Options',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 🔹 Account Section
                const ProfileSectionTitle(title: 'Account'),
                const SizedBox(height: 8),
                const ProfileOption(icon: Icons.edit, title: 'Edit Profile'),
                const ProfileOption(
                  icon: Icons.notifications,
                  title: 'Notifications',
                ),
                const ProfileOption(
                  icon: Icons.lock,
                  title: 'Privacy Settings',
                ),

                const SizedBox(height: 24),

                // 🔹 Activity Section
                const ProfileSectionTitle(title: 'Your Activity & Content'),
                const SizedBox(height: 8),
                ProfileOption(
                  icon: Icons.bookmark,
                  title: 'Saved Recipes',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SavedRecipesScreen(),
                      ),
                    );
                  },
                ),
                const ProfileOption(
                  icon: Icons.archive_outlined,
                  title: 'Archive',
                ),
                const ProfileOption(
                  icon: Icons.history,
                  title: 'Your Activity',
                ),
                const ProfileOption(
                  icon: Icons.alternate_email,
                  title: 'Tags and Mentions',
                ),
                const ProfileOption(
                  icon: Icons.favorite_border,
                  title: 'Favorites',
                ),
                const ProfileOption(
                  icon: Icons.people_alt_outlined,
                  title: 'Close Friends',
                ),
                const ProfileOption(icon: Icons.block, title: 'Blocked'),

                const SizedBox(height: 24),

                // 🔹 General Section
                const ProfileSectionTitle(title: 'General'),
                const SizedBox(height: 8),
                const ProfileOption(
                  icon: Icons.language,
                  title: 'Language and Translations',
                ),
                const ProfileOption(
                  icon: Icons.schedule_outlined,
                  title: 'Time Management',
                ),
                const ProfileOption(
                  icon: Icons.verified_user_outlined,
                  title: 'Account Status',
                ),
                const ProfileOption(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                ),
                const ProfileOption(icon: Icons.info_outline, title: 'About'),
                ProfileOption(
                  icon: Icons.logout,
                  title: 'Logout',
                  isDestructive: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MyLogin()),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Keshav Vyas',
              style: GoogleFonts.robotoSlab(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () => _showMenu(context),
              ),
            ],
            floating: true,
            elevation: 0,
          ),

          // Profile Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ProfileHeader(),
            ),
          ),

          // Stories Row
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: StoryRow(),
            ),
          ),

          // Posts Grid
          const PostsGrid(),
        ],
      ),
    );
  }
}

// 🔹 Profile Header
class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recipes = RecipeData.recipes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Color.fromRGBO(15, 29, 37, 1),
              backgroundImage: AssetImage('images/profile.png'),
            ),
            const SizedBox(width: 40),
            ProfileStat(count: recipes.length, label: 'Posts'),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Keshav Vyas',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          'keshavvyas192002@gmail.com',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              );
            },
            child: const Text('Edit Profile'),
          ),
        ),
      ],
    );
  }
}

// 🔹 Section Title
class ProfileSectionTitle extends StatelessWidget {
  final String title;
  const ProfileSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(15, 29, 37, 1),
      ),
    );
  }
}

// 🔹 Profile Option Tile
class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isDestructive;
  final VoidCallback? onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    this.isDestructive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive
              ? Colors.red
              : const Color.fromRGBO(15, 29, 37, 1),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Colors.red : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: isDestructive ? null : const Icon(Icons.chevron_right),
        onTap:
            onTap ??
            () {
              if (title == 'Edit Profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                );
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Tapped on $title')));
              }
            },
      ),
    );
  }
}

// 🔹 Profile Stat
class ProfileStat extends StatelessWidget {
  final int count;
  final String label;

  const ProfileStat({super.key, required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
      ],
    );
  }
}

// 🔹 Story Row
class StoryRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Color.fromRGBO(15, 29, 37, 1),
                  backgroundImage: AssetImage('images/story.png'),
                ),
                const SizedBox(height: 4),
                Text(
                  'Story ${index + 1}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// 🔹 Posts Grid
class PostsGrid extends StatelessWidget {
  const PostsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final recipes = RecipeData.recipes;

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final recipe = recipes[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RecipeDetailScreen(recipe: recipe),
              ),
            );
          },
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              image: recipe.images.isNotEmpty
                  ? DecorationImage(
                      image: FileImage(recipe.images.first),
                      fit: BoxFit.fitHeight,
                    )
                  : const DecorationImage(
                      image: AssetImage('images/food.png'),
                      fit: BoxFit.fitHeight,
                    ),
            ),
          ),
        );
      }, childCount: recipes.length),
    );
  }
}
