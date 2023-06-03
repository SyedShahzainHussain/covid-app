// import "package:flutter/foundation.dart";
import "dart:convert";

import "/Model/ServicesAllModel.dart";
import "/Services/Utilities/app_url.dart";
import "package:http/http.dart" as http;

class ServicesApi {
  Future<ServiceAllModel> getApi() async {
    final response = await http.get(Uri.parse(AppUrl.worldListApi));
    var body = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ServiceAllModel.fromJson(body);
    } else {
      return ServiceAllModel.fromJson(body);
    }
  }

  var data;
  Future<List<dynamic>> getCountriels() async {
    final response = await http.get(Uri.parse(AppUrl.countriesListApi));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception('Get Countries Failed');
    }
  }
}
