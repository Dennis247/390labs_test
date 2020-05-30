import 'package:flutter/material.dart';

class Repo {
  final String name;
  final String repoOwner;

  Repo({@required this.name, @required this.repoOwner});

  Repo.fromJson(Map<String, dynamic> json)
      : this.name = json['name'],
        this.repoOwner = json['owner']['login'];

  static List<Repo> repoListFromJson(List collection) {
    List<Repo> repoList =
        collection.map((json) => Repo.fromJson(json)).toList();
    return repoList;
  }
}
