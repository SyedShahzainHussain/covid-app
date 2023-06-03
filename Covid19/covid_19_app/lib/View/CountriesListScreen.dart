import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "/View/DetailScreen.dart";
import "package:shimmer/shimmer.dart";

import "../Services/Utilities/Services_api/Services_api.dart";

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController _controller = TextEditingController();
  ServicesApi servicesapi = ServicesApi();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_focusNode.hasFocus) {
          _focusNode.unfocus(); // Unfocus the focus node if it has focus
          return false; // Prevent the default back button behavior
        }
        return true; // Allow the default back button behavior
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: GestureDetector(
          onTap: () {
            _focusNode.unfocus();
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  focusNode: _focusNode,
                  controller: _controller,
                  decoration: InputDecoration(
                      hintText: "Search with Country Name",
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0))),
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                future: servicesapi.getCountriels(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade200,
                      child:  Column(
                        children: [
                          ListLoading(),
                          ListLoading(),
                          ListLoading(),
                          ListLoading(),
                          ListLoading(),
                          ListLoading(),
                          ListLoading(),
                          ListLoading(),
                        ],
                      ),
                    );
                  }

                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 8,
                      itemBuilder: (ctx, index) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade200,
                        child: Column(
                          children: [
                            ListLoading(),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemBuilder: (ctx, index) {
                        String name = snapshot.data![index]["country"];
                        if (_controller.text.isEmpty) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return DetailScreen(
                                  name: snapshot.data![index]["country"],
                                  cases: snapshot.data![index]["cases"],
                                  image: snapshot.data![index]["countryInfo"]
                                      ["flag"],
                                  recovered: snapshot.data![index]["recovered"],
                                  deaths: snapshot.data![index]["deaths"],
                                  critical: snapshot.data![index]["critical"],
                                  todayRecovered: snapshot.data![index]
                                      ["todayRecovered"],
                                );
                              }));
                            },
                            child: Column(
                              children: [
                                ListTile(
                                    title:
                                        Text(snapshot.data![index]["country"]),
                                    subtitle: Text(snapshot.data![index]
                                            ["cases"]
                                        .toString()),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]["countryInfo"]
                                                ["flag"])))
                              ],
                            ),
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(_controller.text.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return DetailScreen(
                                  name: snapshot.data![index]["country"],
                                  cases: snapshot.data![index]["cases"],
                                  image: snapshot.data![index]["countryInfo"]
                                      ["flag"],
                                  recovered: snapshot.data![index]["recovered"],
                                  deaths: snapshot.data![index]["deaths"],
                                  critical: snapshot.data![index]["critical"],
                                  todayRecovered: snapshot.data![index]
                                      ["todayRecovered"],
                                );
                              }));
                            },
                            child: Column(
                              children: [
                                ListTile(
                                    title:
                                        Text(snapshot.data![index]["country"]),
                                    subtitle: Text(snapshot.data![index]
                                            ["cases"]
                                        .toString()),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]["countryInfo"]
                                                ["flag"])))
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                      itemCount: snapshot.data!.length,
                    );
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class ListLoading extends StatelessWidget {
  const ListLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        width: 89,
        height: 10,
        color: Colors.white,
      ),
      subtitle: Container(
        width: 89,
        height: 10,
        color: Colors.white,
      ),
      leading: Container(
        width: 50,
        height: 50,
        color: Colors.white,
      ),
    );
  }
}
