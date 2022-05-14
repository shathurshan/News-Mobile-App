import 'package:api_new_project/Models/newsinfo.dart';
import 'package:api_new_project/Services/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Welcome>? futureWelcome;
  bool isData = false;
  @override
  void initState() {
    super.initState();
    ApiManager().getNews();
    isData = true;
  }

  @override
  Widget build(BuildContext context) {
    var article;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Trending Newes"),
      ),
      body: isData
          ? FutureBuilder<Welcome>(
              future: ApiManager().getNews(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data?.articles.length,
                  itemBuilder: (context, index) {
                    article = snapshot.data?.articles[index];
                    String currentDateTime = DateFormat('yyyy-MM-dd hh:mm')
                        .format(article.publishedAt)
                        .toString();
                    final Uri _url = Uri.parse(article.url);
                    print(_url);
                    void _launchUrl() async {
                      if (!await launchUrl(_url))
                        throw 'Could not launch $_url';
                    }

                    return Container(
                      height: MediaQuery.of(context).size.height * 0.62,
                      width: MediaQuery.of(context).size.height * 0.4,
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.03,
                        top: MediaQuery.of(context).size.height * 0.04,
                        right: MediaQuery.of(context).size.height * 0.03,
                        left: MediaQuery.of(context).size.height * 0.03,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 9,
                            offset: const Offset(
                              3,
                              3,
                            ),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.012,
                            ),
                            child: Text(
                              article.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              article.urlToImage,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height * 0.012,
                                ),
                                child: Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    article.content,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height * 0.002,
                                ),
                                child: Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    'by ' + article.author,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.height * 0.012,
                                ),
                                child: Text(
                                  "Published: "+currentDateTime.toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: _launchUrl,
                                child: Container(
                                  margin: EdgeInsets.all(
                                    MediaQuery.of(context).size.height * 0.012,
                                  ),
                                  child: const Text(
                                    "View More >>>",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            )
          : const Center(
              child: Text("no data"),
            ),
    );
  }
}
