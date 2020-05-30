import 'package:flutter/material.dart';
import 'package:labs_technical_test/model/repo.dart';

class RepoWidget extends StatelessWidget {
  final Repo repo;

  const RepoWidget({Key key, this.repo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(repo.name),
      subtitle: Text(repo.repoOwner),
    );
  }
}
