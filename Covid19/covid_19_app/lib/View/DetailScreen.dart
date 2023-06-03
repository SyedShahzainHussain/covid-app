import "package:flutter/material.dart";

import "WorldStates.dart";

class DetailScreen extends StatelessWidget {
  String? name, image;
  int? cases, recovered, deaths, critical, todayRecovered;
  DetailScreen(
      {required this.name,
      required this.cases,
      required this.image,
      required this.recovered,
      required this.deaths,
      required this.critical,
      required this.todayRecovered});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name.toString()),
        centerTitle: true,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .06,
                        ),
                        ReusableRow(
                          title: "Cases",
                          value: cases.toString(),
                        ),
                        ReusableRow(
                          title: "Recovered",
                          value: recovered.toString(),
                        ),
                        ReusableRow(
                          title: "Deaths",
                          value: deaths.toString(),
                        ),
                        ReusableRow(
                          title: "Critical",
                          value: critical.toString(),
                        ),
                        ReusableRow(
                          title: "Today Recovered",
                          value: todayRecovered.toString(),
                        ),
                       
                      ],
                    ),
                  ),
                ),
                 CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(image.toString()),
                        )
              ],
            )
          ]),
    );
  }
}
