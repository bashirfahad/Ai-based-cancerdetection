import 'package:cancerdetection/utils/custom_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool passEnable = true;
  bool confirmPassEnable = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signupUser() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showMessage("All fields are required.");
      return;
    }

    if (password != confirmPassword) {
      showMessage("Passwords do not match.");
      return;
    }

    try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("User Signed Up: ${userCredential.user?.email}");

      // After user creation, update Firestore with additional information
      User? user = userCredential.user;
      if (user != null) {
        // Set the user data in Firestore with the specified fields
        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          'name': name,
          'email': email,
          'image': '', // Empty initially
          'isDeleted': false, // Initially set to false
          'lastLogin': FieldValue.serverTimestamp(), // Set to current time
          'phoneNumber': '', // You can set this later if required
          'role': 'user', // Default role
          'status': 'away', // Default status
          'uid': int.tryParse(user.uid) ?? 0, // Use user.uid as integer (if needed)
          'createdAt': FieldValue.serverTimestamp(), // Set creation timestamp
          'updatedAt': FieldValue.serverTimestamp(), // Set update timestamp
        });
        print("User data added to Firestore.");
      }

      // Navigate to the next screen after signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomBottomNavBar(profileImageUrl: "")),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Signup failed. Please try again.";
      if (e.code == 'email-already-in-use') {
        message = "Email is already in use.";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email format.";
      } else {
        message = e.message ?? "Something went wrong.";
      }
      showMessage(message);
    }
  }


  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8AABBF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(image: AssetImage("assets/cancer.png"), height: 150),
              SizedBox(height: 40),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: GradientText(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                      colors: [Color(0xff1F4C6B), Color(0xff1F4C6B)],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    buildTextField(_nameController, "Name", Icons.person),
                    SizedBox(height: 10),
                    buildTextField(_emailController, "Email", Icons.email, TextInputType.emailAddress),
                    SizedBox(height: 10),
                    buildPasswordField(_passwordController, "Password", passEnable, () {
                      setState(() => passEnable = !passEnable);
                    }),
                    SizedBox(height: 10),
                    buildPasswordField(_confirmPasswordController, "Confirm Password", confirmPassEnable, () {
                      setState(() => confirmPassEnable = !confirmPassEnable);
                    }),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: signupUser,
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xff1F4C6B),
                            ),
                            child: Center(
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigate to Login Screen
                    },
                    child: Text(
                      " Login",
                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label, IconData icon, [TextInputType keyboardType = TextInputType.text]) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 65,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.black),
        ),
      ),
    );
  }

  Widget buildPasswordField(TextEditingController controller, String label, bool obscureText, VoidCallback toggleVisibility) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 65,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: label,
          prefixIcon: Icon(Icons.lock, color: Colors.black),
          suffixIcon: IconButton(
            onPressed: toggleVisibility,
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          ),
        ),
      ),
    );
  }
}
