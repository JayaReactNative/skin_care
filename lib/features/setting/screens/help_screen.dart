import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {

  static const id = '/helpScreen';

  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Help'),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(
          left: 20
        ),
        child: Container(
          margin: const EdgeInsets.only(
              top: 20
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HelpSection(
                title: 'Getting Started',
                content: 'Learn how to get started with the app and navigate its features.',
              ),
              SizedBox(height: 20.0),
              HelpSection(
                title: 'FAQs',
                content: 'Find answers to frequently asked questions about the app.',
              ),
              SizedBox(height: 20.0),
              HelpSection(
                title: 'Getting Started',
                content: 'Learn how to get started with the app and navigate its features.',
              ),
              SizedBox(height: 20.0),
              HelpSection(
                title: 'Contact Us',
                content: 'If you need further assistance, feel free to contact our support team.',
              ),
              Text('company@gmail.com',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
                fontSize: 14
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HelpSection extends StatelessWidget {
  final String title;
  final String content;

  const HelpSection({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
