import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookedTicketsPage extends StatefulWidget {
  @override
  _BookedTicketsPageState createState() => _BookedTicketsPageState();
}

class _BookedTicketsPageState extends State<BookedTicketsPage> {
  Future<void> _deleteTicket(String ticketId) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(ticketId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking cancelled successfully!')));
    } catch (e) {
      print('Failed to delete booking: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to cancel booking')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Booked Tickets'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No booked tickets found'));
          }

          final bookings = snapshot.data!.docs;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              final data = booking.data() as Map<String, dynamic>;
              final departure =
                  data['itineraries'][0]['segments'][0]['departure'];
              final arrival =
                  data['itineraries'][0]['segments'].last['arrival'];
              final departureTime = DateTime.parse(departure['at']);
              final arrivalTime = DateTime.parse(arrival['at']);
              final airline =
                  data['itineraries'][0]['segments'][0]['carrierCode'];
              final price = data['price']['total'];
              final currency = data['price']['currency'];

              return Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  title: Text(
                      '${departure['iataCode']} to ${arrival['iataCode']}'),
                  subtitle: Text(
                      'Airline: $airline, Price: $price $currency\nDeparture: ${departureTime.toLocal()} Arrival: ${arrivalTime.toLocal()}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteTicket(booking.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
