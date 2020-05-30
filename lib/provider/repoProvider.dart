import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:labs_technical_test/model/repo.dart';
import 'package:labs_technical_test/model/response.dart';

class RepoProvider with ChangeNotifier {
  List<Repo> _repos = [];
  List<Repo> get repos {
    return [..._repos];
  }

  Future<Response> getRepos(String page) async {
    try {
      final String repoUrl =
          "https://api.github.com/search/repositories?q=flutter+language:dart&page=$page&per_page=10";

      final responseData = await http.get(repoUrl);
      if (responseData.statusCode == 200) {
        Iterable extractedRepoList = json.decode(responseData.body)['items'];
        if (extractedRepoList != null) {
          _repos = Repo.repoListFromJson(extractedRepoList);
          return Response(true, "repos loaded sucessfully for page $page");
        }
      }
      final responseMessage = json.decode(responseData.body)['message'];
      return Response(false, "$responseMessage");
    } catch (ex) {
      return Response(
          false, "repo loaded failed error ---------- ${ex.toString()}");
    }
  }
}
