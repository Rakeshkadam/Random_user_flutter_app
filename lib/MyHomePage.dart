
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List usersData;
  bool isLoading = true;
  final String url = "https://randomuser.me/api/?results=50";

  Future getData() async{
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {'Accept': "application/json"}
    );

    List data = jsonDecode(response.body)['results'];
    setState(() {
      usersData = data;
      isLoading = false;

    });
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Users'),
      ),
      body: Container(
        child: Center(
          child: isLoading
          ? CircularProgressIndicator()
          : ListView.builder(
            itemCount: usersData == null ? 0 : usersData.length,
            itemBuilder: (context, index){
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: Image(
                        width: 80.0,
                        height: 80.0,
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          usersData[index]['picture']['thumbnail']
                        ),
                        ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(6.0),
                          ),
                          Text(
                            usersData[index]['name']['first'] + " " +usersData[index]['name']['last'],
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(Icons.phone, size: 18, color: Colors.green,),
                                    ),
                                    TextSpan(
                                      text:" " + "${usersData[index]['phone']}",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(Icons.face, size: 18, color: Colors.green,),
                                    ),
                                    TextSpan(
                                      text:" " + "${usersData[index]['gender']}",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(Icons.email, size: 18, color: Colors.green,),
                                    ),
                                    TextSpan(
                                      text:" " + "${usersData[index]['email']}",
                                      style: TextStyle(fontFamily: 'Roboto',fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ), 
                      ),
                  ],
                ),
              );
            },
          ),

        ),
      ),
    );
  }
}