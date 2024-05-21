import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class HotelPage extends StatefulWidget {
  @override
  _HotelSearchPageState createState() => _HotelSearchPageState();
}

class _HotelSearchPageState extends State<HotelPage> {
  final TextEditingController _destinationController = TextEditingController();
  List<dynamic> _hotels = [];

  Future<void> _searchHotels() async {
    var response = await http.post(
      Uri.parse(
          'http://192.168.1.9:5000/recommend_hotels'), // Replace with your API URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'destination': _destinationController.text,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _hotels = jsonDecode(response.body);
      });
    } else {
      // Handle errors or no results
    }
  }

  Widget _buildHotelCard(Map<String, dynamic> hotel) {
    return Card(
      elevation: 4, // Add shadow to the card
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Add margin
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Add rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(12)), // Round only the top corners
            child: AspectRatio(
              aspectRatio: 16 / 9, // Set aspect ratio for the image
              child: Image.network(
                hotel['Image_link'] ?? 'https://via.placeholder.com/150',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel['Hotel_ Name'] ?? 'Hotel_Name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  hotel['Address'] ?? 'Address',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rate: ${hotel['Rate'] ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: hotel['Hotel_link'] != null
                          ? () => _launchURL(hotel['Hotel_link'])
                          : null,
                      child: Text('Visit Hotel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    try {
      await FlutterWebBrowser.openWebPage(url: url);
    } catch (e) {
      print('Failed to launch URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 76, 175),
        title: Text(
          'Hotel Search',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _destinationController,
              decoration: InputDecoration(
                hintText: 'Enter Destination',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchHotels,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _hotels.length,
              itemBuilder: (context, index) {
                return _buildHotelCard(_hotels[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
