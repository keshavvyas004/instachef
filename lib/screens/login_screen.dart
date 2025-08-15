import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool _seePassword = true;
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(15, 29, 37, 1),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: const Color.fromRGBO(15, 29, 37, 1),
        title: Text(
          'InstaChef',
          style: GoogleFonts.cookie(
            color: const Color.fromRGBO(255, 255, 255, 1),
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            fontSize: 40,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  left: MediaQuery.of(context).size.width * 0.02,
                  right: MediaQuery.of(context).size.width * 0.02,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: [
                    // CircleAvatar(radius: 50),
                    Text(
                      'Login',
                      style: GoogleFonts.cookie(
                        color: const Color.fromRGBO(15, 29, 37, 1),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      decoration: const InputDecoration(
                        prefixIconColor: Color.fromRGBO(0, 0, 0, 1),
                        suffixIconColor: Color.fromRGBO(0, 0, 0, 1),
                        fillColor: Color.fromRGBO(255, 255, 255, 1),
                        border: OutlineInputBorder(),
                        hintText: "Email:",
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      obscureText: _seePassword,
                      decoration: InputDecoration(
                        prefixIconColor: Color.fromRGBO(0, 0, 0, 1),
                        suffixIconColor: Color.fromRGBO(0, 0, 0, 1),
                        fillColor: Color.fromRGBO(255, 255, 255, 1),
                        border: const OutlineInputBorder(),
                        hintText: "Password:",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _seePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _seePassword = !_seePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 30),
                        backgroundColor: const Color.fromRGBO(247, 158, 27, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isLoggedIn = true;
                        });
                        Navigator.pushReplacementNamed(context, 'home');
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'register_1');
                        },
                        child: const Text(
                          'Not A User? Register',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
