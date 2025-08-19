import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onFinish;

  const SplashScreen({Key? key, required this.onFinish}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // 1.5 seconds for animation
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease, // Equivalent to Easing.ease
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut, // Equivalent to Easing.elastic(1)
      ),
    );

    // Start the animations
    _animationController.forward().whenComplete(() {
      // After animations complete, call the onFinish callback
      Future.delayed(const Duration(milliseconds: 500), () {
        widget.onFinish(); // Call the provided onFinish callback
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose the controller to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6200EE), // Primary color for the splash screen background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Container with fade and scale animation
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value, // Bind opacity to animated value
                  child: Transform.scale(
                    scale: _scaleAnimation.value, // Bind scale to animated value
                    child: child,
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Your App Logo',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White color for the logo text
                  ),
                ),
              ),
            ),
            // Loading Text with fade animation
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value, // Bind opacity to animated value
                  child: child,
                );
              },
              child: const Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
