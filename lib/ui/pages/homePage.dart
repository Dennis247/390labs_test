import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:labs_technical_test/provider/repoProvider.dart';
import 'package:labs_technical_test/model/repo.dart';
import 'package:labs_technical_test/ui/widgets/repoWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _pageController = new TextEditingController();
  List<Repo> _repoList = [];
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  void _showFailureDialog(String message) async {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              content: Container(
                  child: Text(
                message,
                style: TextStyle(color: Colors.red),
              )),
              actions: <Widget>[
                FlatButton(
                    child: Text(
                      "OK",
                    ),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    }),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final repoProvider = Provider.of<RepoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter Repos",
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _pageController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Page No is required';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {},
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.grey,
                                size: 15,
                              ),
                              onPressed: () {
                                _pageController.clear();
                                setState(() {
                                  _repoList = [];
                                });
                              }),
                          labelText: "Page No."),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: MaterialButton(
                      shape: StadiumBorder(),
                      color: Colors.blue,
                      onPressed: () async {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        setState(() {
                          _isLoading = true;
                        });
                        var response =
                            await repoProvider.getRepos(_pageController.text);
                        if (!response.isSucessfull) {
                          //show  error pop up
                          _showFailureDialog(response.message);
                        }
                        setState(() {
                          _repoList = repoProvider.repos;
                          _isLoading = false;
                        });
                      },
                      child: Text(
                        "SEARCH",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ))
              ],
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  child: _repoList.length > 0
                      ? Padding(
                          padding: const EdgeInsets.all(5),
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return RepoWidget(
                                repo: _repoList[index],
                              );
                            },
                            itemCount: _repoList.length,
                          ),
                        )
                      : Center(
                          child: Text("Repos Data is currently Empty"),
                        )),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
