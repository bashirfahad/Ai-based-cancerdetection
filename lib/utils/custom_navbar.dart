import 'package:cancerdetection/screens/history_screen.dart';
import 'package:cancerdetection/screens/profile_screen.dart';
import 'package:cancerdetection/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../screens/home_screen.dart';

class CustomBottomNavBar extends StatefulWidget {
  final String? profileImageUrl; // Optional parameter

  const CustomBottomNavBar({super.key, this.profileImageUrl});
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;
  final ImagePicker _picker = ImagePicker();

  // Dynamic list of screens to ensure updated profile image is passed
  List<Widget> get _screens => [
    HomeScreen(profileImageUrl: widget.profileImageUrl),
    SearchScreen(),
    Center(child: Text("QR Scanner", style: TextStyle(fontSize: 20))),
    HistoryScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Method to open the camera
  Future<void> _openCamera() async {
    PermissionStatus status = await Permission.camera.request();

    if (status.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        print("Image path: ${image.path}");
      }
    } else if (status.isDenied) {
      print("Camera permission denied");
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 1),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.black54,
                showUnselectedLabels: true,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
                  BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
                ],
              ),
            ),
          ),

          // Floating Action Button for Camera
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: FloatingActionButton(
              backgroundColor: const Color(0xff1F4C6B),
              shape: const CircleBorder(),
              onPressed: _openCamera,
              child: const Icon(Icons.camera_alt, color: Colors.white, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}