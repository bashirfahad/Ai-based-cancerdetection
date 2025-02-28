import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/report_list.dart';

class HomeScreen extends StatefulWidget {
  final String? profileImageUrl; // Add this line

   HomeScreen({super.key, required this.profileImageUrl}); // Update constructor

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String userName = "User";
  String profileImageUrl = "";

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
      await _firestore.collection("users").doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          userName = userDoc["name"] ?? "User";
          profileImageUrl = userDoc["image"] ?? "";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Profile Row
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance.collection("users").doc(user?.uid).snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
                            return Text("User data not found"); // Don't log out, just show an error
                          }

                          String updatedProfileImageUrl = snapshot.data!.get("image") ?? "";
                          return CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.orangeAccent,
                            child: CircleAvatar(
                              radius: 28,
                              backgroundImage: updatedProfileImageUrl.isNotEmpty
                                  ? NetworkImage(updatedProfileImageUrl)
                                  : const AssetImage("assets/account_image.jpg") as ImageProvider,
                            ),
                          );
                        },
                      ),

                      const SizedBox(width: 8),
                      Text(
                        "Hello $userName !",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.notifications, color: Colors.orangeAccent, size: 30),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Main Container (Health Consultant)
            Container(
              height: MediaQuery.of(context).size.height * 0.28,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: const Color(0xFF6A92B1),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Your new health\nconsultant!",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(
                          width: 200,
                          child: Text(
                            "Empowering early detection: Your gateway to AI-driven cancer insights and patient care.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff1F4C6B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                          child: const Text(
                            "Check now!",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Robot Image
                  Positioned(
                    right: 10,
                    bottom: 0,
                    child: Image.asset(
                      "assets/—Pngtree—a robot is docter_16323861 (1) (1).png",
                      height: 150,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Search Reports
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    "Search Reports",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.search_outlined,
                      color: Color(0xff1F4C6B)),
                ],
              ),
            ),

            // Report List
             Expanded(child: ReportList()),
          ],
        ),
      ),
    );
  }
}
