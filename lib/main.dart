import 'dart:isolate';

import 'package:***REMOVED***/asd.dart';
import 'package:flutter/material.dart';
import 'package:salesforce/salesforce.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: App(),
  ));
}

class App extends StatelessWidget {
  test() async {
    print("do some");

    // SalesforcePlugin.logoutCurrentUser();

    var asd = await SalesforcePlugin.getAuthCredentials();

    // var asd = await SalesforcePlugin.sendRequest(
    //   endPoint: '***REMOVED***',
    //   path: '/me',
    // );

    // var asd = await SalesforcePlugin.sendRequest(
    //     endPoint: '***REMOVED***',
    //     path: '/me/changeLang',
    //     method: 'POST',
    //     payload: {"langCode": "en"});

    // var asd = await SalesforcePlugin.sendRequest(
    //     endPoint: '***REMOVED***', path: '/customer/1015586');

    // var asd = await SalesforcePlugin.sendRequest(
    //     endPoint: '***REMOVED***',
    //     path: '/materials/catalog/1009006');

    print(asd);

    // Repo repo = Repo();
    // repo.setEnt(ent: TEntity(index: 123));
  }

  @override
  Widget build(BuildContext context) {
    // test();
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Center(
        child: Text('data'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => test(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
