import 'package:flutter/material.dart';
import 'package:sawah_app/generated/l10n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class ExplorePage extends StatelessWidget {
  final List<Tour> tours = [
    Tour(
        title:
            "All inclusive Private Giza Pyramids,Sakkara, Memphis,Lunch&Camel",
        description:
            "Enjoy full Day to Giza Pyramids Sakkara plus Memphis Camel-riding alongside the Giza pyramids Best Lunch Qualifed tourguide will lead the trip Using the best Cars to handle the tours Quality tour",
        imageUrl:
            "https://tripplanner.ai/_next/image?url=https%3A%2F%2Fcdn.getyourguide.com%2Fimg%2Ftour%2F64c4d11f01f16.jpeg%2F75.jpg&w=640&q=75",
        bookNowUrl:
            "https://www.viator.com/tours/Cairo/Guided-Half-Day-Trip-to-Giza-Pyramids-with-Camel-Riding/d782-10449P75?mcid=42383&pid=P00104500&medium=api&api_version=2.0&campaign=interesting-tours-section~1ffe8b0d-ab2d-4f20-ae88-69a9684b799d"),
    Tour(
        title:
            "4-Days Nile Cruise From Aswan To Luxor including Abu Simbel and Hot Air Balloon",
        description:
            "The Beauty of Egypt Upper Nile Valley, is best appreciated from the deck of a Nile Cruise ship. Enjoy the riverside scenery and discover the ancient wonders of Egypt passing by pharaonic sites en route between Aswan and Luxor.",
        imageUrl:
            "https://tripplanner.ai/_next/image?url=https%3A%2F%2Fmedia-cdn.tripadvisor.com%2Fmedia%2Fattractions-splice-spp-720x480%2F0b%2F9b%2Fc9%2Fc9.jpg&w=640&q=75",
        bookNowUrl:
            "https://www.viator.com/tours/Aswan/04-Days-03-Nights-Nile-Cruise-from-Aswan-to-Luxor/d796-128216P66?mcid=42383&pid=P00104500&medium=api&api_version=2.0&campaign=interesting-tours-section~1ffe8b0d-ab2d-4f20-ae88-69a9684b799d"),
    Tour(
        title: "Full-Day Historical Alexandria Tour",
        description:
            "Journey through Alexandria and visit the Roman theater of Kom El-Deka on a day tour from Cairo. See the Kom El Shoqafa Catacombs, the Roman triclinium, Pompey's Pillar, and the Citadel of Qaitbay.",
        imageUrl:
            "https://tripplanner.ai/_next/image?url=https%3A%2F%2Fcdn.getyourguide.com%2Fimg%2Ftour%2F5da1b8c45cebc.jpeg%2F75.jpg&w=640&q=75",
        bookNowUrl:
            "https://www.getyourguide.com/cairo-l92/from-cairo-full-day-tour-of-historical-alexandria-t312823/?partner_id=XKQT9ML&psrc=partner_api&currency=USD&cmp=interesting-tours-section~1ffe8b0d-ab2d-4f20-ae88-69a9684b799d"),
    Tour(
        title: "Dolphin Watching Boat Tour with Snorkeling & Lunch",
        description:
            "Get up close to dolphins on a snorkel trip from Hurghada. Enjoy a boat tour to areas in the open sea where you can swim or snorkel with dolphins among colorful coral reefs.",
        imageUrl:
            "https://tripplanner.ai/_next/image?url=https%3A%2F%2Fcdn.getyourguide.com%2Fimg%2Ftour%2F64c3d5b0da7d8.jpeg%2F75.jpg&w=640&q=75",
        bookNowUrl:
            "https://www.getyourguide.com/hurghada-l403/9-hour-dolphin-snorkeling-tour-from-hurghada-t35090/?partner_id=XKQT9ML&psrc=partner_api&currency=USD&cmp=interesting-tours-section~5e2afb45-0209-47c1-9e8c-c30f63426c3b"),
    Tour(
        title: "ATV Quad Safari, Camel Ride & Bedouin Village Tour",
        description:
            "Spark your adrenaline on a quad ride through the desert. Depart from Hurghada and experience a thrilling ride through the dunes to a Bedouin village. Try traditional tea and ride a camel.",
        imageUrl:
            "https://tripplanner.ai/_next/image?url=https%3A%2F%2Fcdn.getyourguide.com%2Fimg%2Ftour%2F6474f894e83e8.jpeg%2F75.jpg&w=640&q=75",
        bookNowUrl:
            "https://www.getyourguide.com/hurghada-l403/hurghada-desert-safari-atv-and-camel-adventure-tour-t35073/?partner_id=XKQT9ML&psrc=partner_api&currency=USD&cmp=interesting-tours-section~5e2afb45-0209-47c1-9e8c-c30f63426c3b"),
    Tour(
        title: "Diving & Snorkeling Cruise Tour w Lunch & Drinks",
        description:
            "Explore the beauty of the underwater world by diving and snorkeling in the Red Sea. Enjoy the experience with our professional instructors. Have lunch and unlimited drinks on board",
        imageUrl:
            "https://tripplanner.ai/_next/image?url=https%3A%2F%2Fcdn.getyourguide.com%2Fimg%2Ftour%2F8fad8d3746e32927598122c27a62b8c55355f5c36766c77e3ad93d4271356a6b.jpg%2F75.jpg&w=640&q=75",
        bookNowUrl:
            "https://www.getyourguide.com/hurghada-l403/hurghada-6-hour-dive-trip-with-two-dive-sites-t35140/?partner_id=XKQT9ML&psrc=partner_api&currency=USD&cmp=interesting-tours-section~5e2afb45-0209-47c1-9e8c-c30f63426c3b"),
    Tour(
        title: "Star Watching Desert Adventure by Jeep with Dinner",
        description:
            "Go on a safari tour through the Red Sea desert on this stargazing adventure. Watch the sunset in the desert, savor a BBQ dinner, and travel to an observatory to view the sky and learn about the stars.",
        imageUrl:
            "https://tripplanner.ai/_next/image?url=https%3A%2F%2Fcdn.getyourguide.com%2Fimg%2Ftour%2F635ad88e99072.jpeg%2F75.jpg&w=640&q=75",
        bookNowUrl:
            "https://www.getyourguide.com/hurghada-l403/hurghada-desert-star-watching-adventure-by-jeep-t354016/?partner_id=XKQT9ML&psrc=partner_api&currency=USD&cmp=interesting-tours-section~5e2afb45-0209-47c1-9e8c-c30f63426c3b"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 76, 175),
        title: Text(
          (S.of(context).explore),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: tours.length,
        itemBuilder: (context, index) {
          final tour = tours[index];
          return TourCard(tour: tour);
        },
      ),
    );
  }
}

class Tour {
  final String title;
  final String description;
  final String imageUrl;
  final String bookNowUrl;

  Tour({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.bookNowUrl,
  });
}

class TourCard extends StatelessWidget {
  final Tour tour;

  TourCard({required this.tour});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              tour.imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              tour.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              tour.description,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromARGB(255, 130, 76, 175), // Background color
                foregroundColor: Colors.white, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                _launchURL(tour.bookNowUrl);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Book now"),
                  Icon(Icons.arrow_right_alt),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) {
    FlutterWebBrowser.openWebPage(
      url: url,
      customTabsOptions: CustomTabsOptions(
        colorScheme: CustomTabsColorScheme.dark,
        instantAppsEnabled: true,
        showTitle: true,
        urlBarHidingEnabled: true,
      ),
      safariVCOptions: SafariViewControllerOptions(
        barCollapsingEnabled: true,
        preferredBarTintColor: Colors.green,
        preferredControlTintColor: Colors.white,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        modalPresentationCapturesStatusBarAppearance: true,
      ),
    );
  }
}
