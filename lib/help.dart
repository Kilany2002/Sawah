import 'package:flutter/material.dart';
import 'package:sawah_app/generated/l10n.dart';

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 76, 175),
        title: Text(
          (S.of(context).help_support),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('FAQs'),
            onTap: () {
              // Navigate to FAQs page
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('Contact Support'),
            onTap: () {
              // Navigate to Contact Support page
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Tutorials and Guides'),
            onTap: () {
              // Navigate to Tutorials and Guides page
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text('Feedback'),
            onTap: () {
              // Navigate to Feedback page
            },
          ),
          ListTile(
            leading: Icon(Icons.build),
            title: Text('Troubleshooting'),
            onTap: () {
              // Navigate to Troubleshooting page
            },
          ),
          ListTile(
            leading: Icon(Icons.forum),
            title: Text('Community Forum'),
            onTap: () {
              // Navigate to Community Forum page
            },
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('Knowledge Base'),
            onTap: () {
              // Navigate to Knowledge Base page
            },
          ),
          ListTile(
            leading: Icon(Icons.update),
            title: Text('Update Log'),
            onTap: () {
              // Navigate to Update Log page
            },
          ),
          ListTile(
            leading: Icon(Icons.new_releases),
            title: Text('Request Feature'),
            onTap: () {
              // Navigate to Request Feature page
            },
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Terms and Conditions / Privacy Policy'),
            onTap: () {
              // Navigate to Terms and Conditions / Privacy Policy page
            },
          ),
        ],
      ),
    );
  }
}
