import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp1 extends StatefulWidget {
  const SignUp1({super.key});

  @override
  State<SignUp1> createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        title: Text(
          'InstaChef',
          style: GoogleFonts.cookie(
            color: const Color.fromARGB(255, 0, 0, 0),
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
                  color: const Color.fromRGBO(15, 29,37, 1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: [
                    // CircleAvatar(radius: 50),
                    Text(
                      'Sign Up',
                      style: GoogleFonts.cookie(
                        color: Color.fromRGBO(255, 255, 255, 1),
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
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: "Name:",
                        prefixIcon: Icon(Icons.verified_user),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      decoration: const InputDecoration(
                        prefixIconColor: Color.fromRGBO(0, 0, 0, 1),
                        suffixIconColor: Color.fromRGBO(0, 0, 0, 1),
                        fillColor: Color.fromRGBO(255, 255, 255, 1),
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: "Date Of Birth:",
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      decoration: const InputDecoration(
                        prefixIconColor: Color.fromRGBO(0, 0, 0, 1),
                        suffixIconColor: Color.fromRGBO(0, 0, 0, 1),
                        fillColor: Color.fromRGBO(255, 255, 255, 1),
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: "Phone Number",
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40),
                        backgroundColor: Color.fromRGBO(247, 158, 27, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'register_2');
                      },

                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Next',
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(width: 20),
                          Icon(
                            Icons.arrow_forward,
                            size: 35,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40),
                        backgroundColor: Color.fromRGBO(247, 158, 27, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'login');
                      },

                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 35,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Back',
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              fontSize: 30,
                            ),
                          ),
                        ],
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
