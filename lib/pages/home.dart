import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/pages/newsDetailPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<NewsModel> news = [];
  String query = '';
  String category = '';
  int page = 1;
  @override
  void initState() {
    super.initState();
    _getNews(query, category);
  }

  void _getCategories() {
    categories = CategoryModel.getCategories();
  }

  void _getNews(String query, String category) async {
    List<NewsModel> fetchedNews =
        await NewsModel.getNews(query, category, page);
    setState(() {
      news = fetchedNews;
    });
  }

  void _getInitialInfo() {
    _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();

    return Scaffold(
        appBar: appBar(),
        body: ListView(children: [
          searchBar(),
          SizedBox(height: 15),
          categorySelector(),
          SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text('Top News',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(height: 15),
              news.isEmpty
                  ? Center(
                      child: CircularProgressIndicator()) // Loading indicator
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: news.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 15),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NewsDetailPage(newsItem: news[index]),
                              ),
                            );
                          },
                          child: Container(
                            height: 600,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black38.withOpacity(0.3),
                                      offset: Offset(0, 10),
                                      blurRadius: 40.0,
                                      spreadRadius: 0)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    width: 450,
                                    height: 300,
                                    child: Image.network(news[index].imagePath,
                                        fit: BoxFit.contain)
                                    // child: news[index].imagePath.endsWith('.svg')
                                    //     ? SvgPicture.network(news[index].imagePath)
                                    //     : Image.network(
                                    //         news[index].imagePath,
                                    //         ,
                                    //       ),
                                    ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        news[index].headline,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                        softWrap: true,
                                      ),
                                      SizedBox(height: 8),
                                      Text(news[index].description,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                          )),
                                      SizedBox(height: 6),
                                      Text(news[index].source,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
            ],
          ),
        ]));
  }

  Column categorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text('Category',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 50,
          child: ListView.separated(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20, right: 20),
            separatorBuilder: (context, index) => SizedBox(width: 25),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    category = categories[index].name;
                    _getNews(query, category);
                    category = '';
                  });
                },
                child: Container(
                  width: 135,
                  decoration: BoxDecoration(
                    color: categories[index].boxColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(categories[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16,
                        )),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Container searchBar() {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.19),
            spreadRadius: 0,
            blurRadius: 40,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: TextField(
        onSubmitted: (value) {
          print(value);
          setState(() {
            query = value;
            _getNews(query, category);
            query = ''; // Fetch news based on search query
          });
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Search for pankcakes',
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15),
            child: SvgPicture.asset('icons/search.svg', height: 25, width: 25),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('News',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
      centerTitle: true,
    );
  }
}
