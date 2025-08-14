import 'package:flutter/material.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
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
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // --- Account Settings Section ---
                    const ProfileSectionTitle(title: 'Account'),
                    const SizedBox(height: 8),
                    const ProfileOption(
                      icon: Icons.edit,
                      title: 'Edit Profile',
                    ),
                    const ProfileOption(
                      icon: Icons.notifications,
                      title: 'Notifications',
                    ),
                    const ProfileOption(
                      icon: Icons.lock,
                      title: 'Privacy Settings',
                    ),
                    const SizedBox(height: 24),
                    // --- Your Activity & Content Section ---
                    const ProfileSectionTitle(title: 'Your Activity & Content'),
                    const SizedBox(height: 8),
                    const ProfileOption(
                      icon: Icons.bookmark_border,
                      title: 'Saved',
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
                    const ProfileOption(
                      icon: Icons.block,
                      title: 'Blocked',
                    ),
                    const SizedBox(height: 24),
                    // --- General Settings Section ---
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
                    const ProfileOption(
                      icon: Icons.info_outline,
                      title: 'About',
                    ),
                    const ProfileOption(
                      icon: Icons.logout,
                      title: 'Logout',
                      isDestructive: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The app bar for the profile page.
      appBar: AppBar(
        title: const Text('John Doe'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _showMenu(context),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const ProfileHeader(),
                  const Divider(height: 32),
                  // A row of stories is added here.
                  const StoryRow(),
                  const Divider(height: 32),
                ],
              ),
            ),
          ),
          const PostsGrid(),
        ],
      ),
    );
  }
}

// A widget for the profile picture and user information at the top.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // --- Profile Picture Section ---
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.teal,
              backgroundImage: NetworkImage('https://placehold.co/200x200/cccccc/000000?text=User'),
            ),
            // --- User Stats Section ---
            const ProfileStat(count: 12, label: 'Posts'),
            const ProfileStat(count: 1234, label: 'Followers'),
            const ProfileStat(count: 567, label: 'Following'),
          ],
        ),
        const SizedBox(height: 16),
        // --- User Details Section ---
        const Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'john.doe@example.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // --- Edit Profile Button ---
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              // TODO: Implement edit profile logic here.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit Profile Button Tapped')),
              );
            },
            child: const Text('Edit Profile'),
          ),
        ),
      ],
    );
  }
}

// A reusable widget for the section titles (e.g., "Account", "General").
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
        color: Colors.teal,
      ),
    );
  }
}

// A reusable widget for each profile option item (e.g., "Edit Profile", "Logout").
class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isDestructive;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? Colors.red : Colors.teal,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Colors.red : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: isDestructive ? null : const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: Implement navigation or action for each option.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tapped on $title')),
          );
        },
      ),
    );
  }
}

// A new reusable widget for the followers/following/posts count.
class ProfileStat extends StatelessWidget {
  final int count;
  final String label;

  const ProfileStat({
    super.key,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

// A widget to display a horizontal scrollable list of stories.
class StoryRow extends StatelessWidget {
  const StoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8, // Placeholder for stories
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.teal,
                  // Placeholder image for the story.
                  backgroundImage: NetworkImage('https://placehold.co/100x100/cccccc/000000?text=Story ${index + 1}'),
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

// A widget to display a grid of posts.
class PostsGrid extends StatelessWidget {
  const PostsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 columns
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: 30, // Placeholder for 30 posts
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            image: DecorationImage(
              // Placeholder image for the recipe post.
              image: NetworkImage('https://placehold.co/200x200/cccccc/000000?text=Post ${index + 1}'),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}