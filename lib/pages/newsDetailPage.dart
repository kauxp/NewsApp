import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/models/news.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';

class NewsDetailPage extends StatelessWidget {
  NewsModel newsItem; // Receive the news item
  NewsDetailPage({required this.newsItem});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    print(uri);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error occurred: $e');
      // Optionally show a Snackbar or AlertDialog with the error
    }
  }

  @override
  Widget build(BuildContext context) {
    print(newsItem);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          newsItem.headline,
        ), // Display the headline as the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 450,
                height: 300,
                child: Image.network(newsItem.imagePath, fit: BoxFit.contain)),
            SizedBox(height: 16),

            // Headline
            Text(
              newsItem.headline,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Source
            Text(
              'Source: ${newsItem.source}',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              '{newsItem.date}',
              style: TextStyle(color: Colors.grey),
            ),
            Html(
              data: newsItem.content, // Directly use the HTML content
              style: {
                "body": Style(
                  fontSize: FontSize(16.0), // Set font size for body text
                ),
              },
            ),
            SizedBox(height: 8),
            GestureDetector(
                onTap: () {
                  // Open the original news in the browser
                  // using the URL
                  _launchURL(newsItem.url);
                },
                child: Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: [Color(0xFF64BEFF), Color(0xFF4685B2)])),
                    child: Center(
                        child: Text("Read Full Article",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                                fontSize: 14)))))
          ],
        ),
      ),
    );
  }
}
