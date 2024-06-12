import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class PlaneTicketBooking extends StatefulWidget {
  @override
  _PlaneTicketBookingState createState() => _PlaneTicketBookingState();
}

class _PlaneTicketBookingState extends State<PlaneTicketBooking> {
  final _formKey = GlobalKey<FormState>();
  String origin = '';
  String destination = 'CAI'; // Default to Cairo International Airport
  DateTime? departureDate;
  DateTime? returnDate;
  int travellers = 1;
  String cabinClass = 'ECONOMY';
  List flights = [];
  bool isLoading = false;

  TextEditingController departureController = TextEditingController();
  TextEditingController returnController = TextEditingController();

  Future<String> getAccessToken() async {
    final response = await http.post(
      Uri.parse('https://test.api.amadeus.com/v1/security/oauth2/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'client_credentials',
        'client_id':
            'etA2DvReZdY5p5sBb9IGU6U5VFJfmZpW', // Replace with your actual API Key
        'client_secret':
            'EVVjX8ZpTPa1AroU', // Replace with your actual API Secret
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['access_token'];
    } else {
      final errorData = jsonDecode(response.body);
      print('Failed to get access token: ${errorData['error_description']}');
      throw Exception('Failed to get access token');
    }
  }

  Future<void> searchFlights() async {
    if (departureDate == null || origin.isEmpty || destination.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill all required fields')));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final accessToken = await getAccessToken();
      final requestUrl =
          'https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode=$origin&destinationLocationCode=$destination&departureDate=${departureDate?.toIso8601String().split('T')[0]}&adults=$travellers&travelClass=$cabinClass';
      print('Request URL: $requestUrl'); // Print the request URL for debugging

      final response = await http.get(
        Uri.parse(requestUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      print(
          'Response: ${response.body}'); // Print the full response for debugging

      if (response.statusCode == 200) {
        setState(() {
          flights = jsonDecode(response.body)['data'];
          isLoading = false;
        });
      } else {
        final errorData = jsonDecode(response.body);
        print(
            'Failed to fetch flight data: ${errorData['errors'][0]['detail']}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Exception occurred: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> bookFlight(Map<String, dynamic> flight) async {
    try {
      await FirebaseFirestore.instance.collection('bookings').add(flight);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Flight booked successfully!')));
    } catch (e) {
      print('Failed to book flight: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to book flight')));
    }
  }

  Future<void> selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          departureDate = picked;
          departureController.text = picked
              .toLocal()
              .toIso8601String()
              .split('T')[0]; // Update the text field
        } else {
          returnDate = picked;
          returnController.text = picked
              .toLocal()
              .toIso8601String()
              .split('T')[0]; // Update the text field
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 76, 175),
        title: Text(
          'Book a Plane Ticket',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'From (Origin)'),
                  onChanged: (value) {
                    setState(() {
                      origin = value;
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  value: destination,
                  items: [
                    DropdownMenuItem(child: Text('Cairo (CAI)'), value: 'CAI'),
                    DropdownMenuItem(
                        child: Text('Alexandria (ALY)'), value: 'ALY'),
                    DropdownMenuItem(child: Text('Luxor (LXR)'), value: 'LXR'),
                    DropdownMenuItem(
                        child: Text('Sharm El Sheikh (SSH)'), value: 'SSH'),
                    DropdownMenuItem(
                        child: Text('Hurghada (HRG)'), value: 'HRG'),
                  ],
                  onChanged: (value) {
                    setState(() {
                      destination = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'To (Destination)'),
                ),
                GestureDetector(
                  onTap: () => selectDate(context, true),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: departureController,
                      decoration: InputDecoration(
                        labelText: 'Depart',
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => selectDate(context, false),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: returnController,
                      decoration: InputDecoration(
                        labelText: 'Return',
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  initialValue: '1',
                  decoration:
                      InputDecoration(labelText: 'Number of Travellers'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      travellers = int.parse(value);
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  value: cabinClass,
                  items: ['ECONOMY', 'PREMIUM_ECONOMY', 'BUSINESS', 'FIRST']
                      .map((label) => DropdownMenuItem(
                            child: Text(label),
                            value: label,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      cabinClass = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Cabin Class'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      searchFlights();
                    }
                  },
                  child: Text('Search Flights'),
                ),
                SizedBox(height: 20),
                isLoading
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        shrinkWrap:
                            true, // Adjust according to the content size
                        physics:
                            NeverScrollableScrollPhysics(), // Disable inner scrolling
                        itemCount: flights.length,
                        itemBuilder: (context, index) {
                          final flight = flights[index];
                          final itinerary = flight['itineraries'][0];
                          final segments = itinerary['segments'];
                          final departure = segments.first['departure'];
                          final arrival = segments.last['arrival'];
                          final departureTime = DateTime.parse(departure['at']);
                          final arrivalTime = DateTime.parse(arrival['at']);
                          final airline = segments.first['carrierCode'];
                          final price = flight['price']['total'];
                          final currency = flight['price']['currency'];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              title: Text(
                                  '${departure['iataCode']} to ${arrival['iataCode']}'),
                              subtitle: Text(
                                  'Airline: $airline, Price: $price $currency\nDeparture: ${departureTime.toLocal()} Arrival: ${arrivalTime}'),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  bookFlight(flight);
                                },
                                child: Text('Book'),
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
