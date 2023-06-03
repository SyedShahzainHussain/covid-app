import "dart:convert";

import "package:flutter/material.dart";

class postModel {
  int? albumId;
  int? id;
  String? title;
  String? url;

  postModel({this.albumId, this.id, this.title, this.url});

  postModel.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}
