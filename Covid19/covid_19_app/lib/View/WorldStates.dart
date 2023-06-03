import "package:flutter/material.dart";
import "/Services/Utilities/Services_api/Services_api.dart";
import "/View/CountriesListScreen.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:pie_chart/pie_chart.dart";
import "../Model/ServicesAllModel.dart";

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();

  ServicesApi servicesapi = ServicesApi();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<ServiceAllModel>(
          future: servicesapi.getApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
                           return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  PieChart(
                    dataMap: {
                      "Total": double.parse(snapshot.data!.cases.toString()),
                      "Recovered":
                          double.parse(snapshot.data!.recovered.toString()),
                      "Deaths": double.parse(snapshot.data!.deaths.toString()),
                    },
                    chartRadius: MediaQuery.of(context).size.width / 3.2,
                    chartValuesOptions: const ChartValuesOptions(
                        showChartValuesInPercentage: true),
                    legendOptions: const LegendOptions(
                        legendPosition: LegendPosition.left),
                    animationDuration: const Duration(milliseconds: 1200),
                    chartType: ChartType.ring,
                    colorList: colorList,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.06),
                    child: Card(
                      child: Column(
                        children: [
                          ReusableRow(
                              title: 'Total',
                              value: snapshot.data!.cases.toString()),
                          ReusableRow(
                              title: 'Deaths',
                              value: snapshot.data!.deaths.toString()),
                          ReusableRow(
                              title: 'Recovered',
                              value: snapshot.data!.recovered.toString()),
                          ReusableRow(
                              title: 'Active',
                              value: snapshot.data!.active.toString()),
                          ReusableRow(
                              title: 'Critical',
                              value: snapshot.data!.critical.toString()),
                          ReusableRow(
                              title: 'Today Death',
                              value: snapshot.data!.todayDeaths.toString()),
                          ReusableRow(
                              title: 'Today Recovered',
                              value: snapshot.data!.todayRecovered.toString()),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CountriesListScreen()));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xff1aa260),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Text("Track Countries")),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }
}
