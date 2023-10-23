import 'package:flutter/material.dart';

class IdeaDetail extends StatelessWidget {
  final String title;
  final String description;
  final String upvotes;
  final String downvotes;
  const IdeaDetail(
      {super.key,
      required this.title,
      required this.description,
      required this.upvotes,
      required this.downvotes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 48,
            ),
            Text("Title: $title"),
            const SizedBox(
              height: 16,
            ),
            Text("Description: $description"),
            const SizedBox(
              height: 16,
            ),
            Text("Upvotes: $upvotes"),
            const SizedBox(
              height: 16,
            ),
            Text("Downvotes: $downvotes"),
          ],
        ),
      ),
    );
  }
}
