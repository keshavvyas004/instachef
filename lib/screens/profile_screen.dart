import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  children: const [
                    Center(
                      child: Text(
                        'Settings & Options',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ProfileSectionTitle(title: 'Account'),
                    SizedBox(height: 8),
                    ProfileOption(icon: Icons.edit, title: 'Edit Profile'),
                    ProfileOption(
                      icon: Icons.notifications,
                      title: 'Notifications',
                    ),
                    ProfileOption(icon: Icons.lock, title: 'Privacy Settings'),
                    SizedBox(height: 24),
                    ProfileSectionTitle(title: 'Your Activity & Content'),
                    SizedBox(height: 8),
                    ProfileOption(icon: Icons.bookmark_border, title: 'Saved'),
                    ProfileOption(
                      icon: Icons.archive_outlined,
                      title: 'Archive',
                    ),
                    ProfileOption(icon: Icons.history, title: 'Your Activity'),
                    ProfileOption(
                      icon: Icons.alternate_email,
                      title: 'Tags and Mentions',
                    ),
                    ProfileOption(
                      icon: Icons.favorite_border,
                      title: 'Favorites',
                    ),
                    ProfileOption(
                      icon: Icons.people_alt_outlined,
                      title: 'Close Friends',
                    ),
                    ProfileOption(icon: Icons.block, title: 'Blocked'),
                    SizedBox(height: 24),
                    ProfileSectionTitle(title: 'General'),
                    SizedBox(height: 8),
                    ProfileOption(
                      icon: Icons.language,
                      title: 'Language and Translations',
                    ),
                    ProfileOption(
                      icon: Icons.schedule_outlined,
                      title: 'Time Management',
                    ),
                    ProfileOption(
                      icon: Icons.verified_user_outlined,
                      title: 'Account Status',
                    ),
                    ProfileOption(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                    ),
                    ProfileOption(icon: Icons.info_outline, title: 'About'),
                    ProfileOption(
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
            backgroundColor: const Color.fromARGB(0, 105, 103, 103),
            actions: [
              IconButton(
                icon: const Icon(Icons.menu),
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
          PostsGrid(),
        ],
      ),
    );
  }
}

// --- Rest of your widgets stay the same ---

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            CircleAvatar(
              radius: 50,
              backgroundColor: Color.fromRGBO(15, 29, 37, 1),
              backgroundImage: AssetImage('images/profile.png'),
            ),
            ProfileStat(count: 12, label: 'Posts'),
            ProfileStat(count: 1234, label: 'Followers'),
            ProfileStat(count: 567, label: 'Following'),
          ],
        ),
        const SizedBox(height: 16),
        const Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Keshav Vyas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'keshavVyas@hotmail.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
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
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Tapped on $title')));
        },
      ),
    );
  }
}

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

class StoryRow extends StatelessWidget {
  const StoryRow({super.key});

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

class PostsGrid extends StatelessWidget {
  const PostsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            image: const DecorationImage(
              image: AssetImage('images/food.png'),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
