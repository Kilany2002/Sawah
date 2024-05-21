import 'package:flutter/material.dart';

class Mountain {
  final String name;
  final String imageUrl;
  final String description; // Add description field

  Mountain(this.name, this.imageUrl, this.description);
}

class MountainPage extends StatelessWidget {
  final List<Mountain> cities = [
    Mountain('Jabal Mousa', 'assets/images/Jabal Mousa.jpg',
        'Mount Sinai, also known as Jabal Musa, is a mountain on the Sinai Peninsula of Egypt. It is one of several locations claimed to be the biblical Mount Sinai, the place where, according to the Torah, Bible, and Quran, Moses received the Ten Commandments.'),
    Mountain('Mount Catherine', 'assets/images/Mount Catherine.jpg',
        'Mount Catherine, locally known as Gabal Katrîne, is the highest mountain in Egypt. It is located near the town of Saint Catherine in the South Sinai Governorate. The name is derived from the Christian tradition that angels transported to this mountain the body of the martyred Saint Catherine of Alexandria.'),
    Mountain('Willow Peak', 'assets/images/Willow Peak.jpg',
        'Willow Peak or Ras es-Safsafeh is a mountain in the Sinai Peninsula. The mountain peak overlooks Saint Catherine Monastery, and is situated approximately 1km to the west. Christian tradition considers the mountain to be the biblical Mount Horeb.'),
    Mountain('Ras Kouroun', 'assets/images/Ras Kouroun.jpg',
        'Ras Kasaroun or El-Kas, also known as Casius Mons in Latin, or Kasion Oros to Greek geographers such as Herodotus, is a small mountain and a former town near the marshy Lake Bardawil, the "Serbonian Bog" of Herodotus, where Zeus ancient opponent Typhon was "said to be hidden".'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 76, 175),
        title: Text(
          'Mountain in Egypt',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: cities.map((Mountain) {
          return GestureDetector(
            onTap: () {
              // Show dialog when Mountain card is tapped
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(Mountain.name),
                    content: Text(Mountain.description),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Mountain.imageUrl, height: 100),
                  Text(Mountain.name),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
