import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawah_app/Screens/beach.dart';
import 'package:sawah_app/Screens/booking.dart';
import 'package:sawah_app/Screens/cities.dart';
import 'package:sawah_app/Screens/hotel.dart';
import 'package:sawah_app/Screens/mountain.dart';
import 'package:sawah_app/Screens/museum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sawah_app/attraction.dart';
import 'package:sawah_app/generated/l10n.dart';
import 'package:sawah_app/plan.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<HomeScreen> {
  final Map<String, String> cityImages = {
    'Cairo': 'assets/images/cairo.jpg',
    'Luxor': 'assets/images/louxor.jpg',
    'Aswan': 'assets/images/aswan_dam.jpg',
    'Hurghada': 'assets/images/hurghada.jpg',
    'Alexandria': 'assets/images/Alexandria.jpg',
    'Sharm ElSheikh': 'assets/images/Port Said.JPG',
    // Add more cities and their corresponding images as needed
  };

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPlan()),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: ListView(
          children: [
            _buildHeader(screenHeight),
            _buildIconsGrid(screenWidth),
            _buildTripCards(
                screenHeight), // Include the Firestore trip cards here
            const SizedBox(height: 10), // Some spacing
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double screenHeight) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            height: screenHeight * 0.2,
            width: screenHeight * 0.5, // Adjust height based on screen height
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Image.asset(
              "assets/images/muizz_street.jpg",
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.5),
              colorBlendMode: BlendMode.darken,
            ),
          ),
        ),
        Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(35.0),
                child: Text(
                  (S.of(context).trip_planner_in_egypt),
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
            Text(
              (S.of(context).explore_best_place_in_egypt),
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 20),
          ],
        ),
      ],
    );
  }

  Widget _buildIconsGrid(double screenWidth) {
    return SizedBox(
      height: screenWidth *
          0.6, // Adjust height based on screen width to fit all icons
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Adjust the number of icons per row
            mainAxisExtent: screenWidth * 0.3, // Adjust height of each item
          ),
          children: [
            _iconCard('city.png', S.of(context).cities, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CitiesPage()),
              );
            }),
            _iconCard('beach.png', S.of(context).beach, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BeachPage()),
              );
            }),
            _iconCard('hotel.png', S.of(context).hotel, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HotelPage()),
              );
            }),
            _iconCard('mountain.png', S.of(context).mountain, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MountainPage()),
              );
            }),
            _iconCard('museum.png', S.of(context).museum, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MuseumPage()),
              );
            }),
            _iconCard('plane.png', S.of(context).book_flight, () {
              // Add your localization string if available
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PlaneTicketBooking()), // Navigate to PlaneTicketBooking screen
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTripCards(double screenHeight) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return const Center(child: Text("No user logged in"));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('trips')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  (S.of(context).your_trips),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: screenHeight / 800, // Adjust aspect ratio
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var tripDoc = snapshot.data!.docs[index];
                  var tripData = tripDoc['input'];
                  var destination = tripData['Destination'] ?? 'Unknown';

                  // Get the image for the destination
                  var image =
                      cityImages[destination] ?? 'assets/images/unknown.jpg';

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AttractionsList(
                            attractionsData: tripDoc['output'],
                            tripData: tripData,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              child: Image.asset(
                                image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(destination),
                            subtitle:
                                Text('${tripData['Duration (days)']} days'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteTrip(tripDoc.id),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (S.of(context).create_your_first_trip),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                IconButton(
                  icon: Icon(Icons.add_circle,
                      size: 50, color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewPlan()),
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void _deleteTrip(String docId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No user logged in"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('trips')
          .doc(docId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text((S.of(context).trip_deleted_successfully)),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to delete trip: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _iconCard(String image, String label, VoidCallback onTap) {
    return Card(
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(color: Colors.black38, blurRadius: 4)
                ],
              ),
              child: Image.asset("assets/images/$image", width: 60, height: 60),
            ),
          ),
          SizedBox(height: 20, child: Text(label)),
        ],
      ),
    );
  }
}
