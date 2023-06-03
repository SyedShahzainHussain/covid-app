import "dart:convert";

import "package:flutter/material.dart";
// ignore: depend_on_referenced_packages
import "package:http/http.dart" as http;
import "./UsersModel.dart";

class RestApi extends StatelessWidget {
  const RestApi({super.key});

  @override
  Widget build(BuildContext context) {
    Future<UsersModel> getApi() async {
      final response = await http.get(Uri.parse('https://webhook.site/ebc32cb0-f74c-49fd-8ff7-aa80fa5628ca'));
      var data = jsonDecode(response.body.toString());
      print(data.toString());
      if (response.statusCode == 200) {
        return UsersModel.fromJson(data);
      } else {
        return UsersModel.fromJson(data);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Rest Api'),
      ),
      body: Column(children: [
        Expanded(
            child: FutureBuilder<UsersModel>(
                future: getApi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Text(index.toString()),
                          ],
                        );
                      },
                      itemCount: snapshot.data!.data!.length,
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }))
      ]),
    );
  }
}
