import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';

class FuturesScreenView extends StatelessWidget {
  const FuturesScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Future screen"),
        centerTitle: true,
      ),
      body: Center(
        //FutureBuilder 2 wedigt ,future , bulider
        //la future function adane
        //la bulider alen hata function excute abet tu ama ba user nishan bda
        child: Column(
          children: [
            Container(
              height: 100,
              child: FutureBuilder(
                  future: waitForFiveSec(),
                  //context , snapshot amana atwani nawakani bgorit
                  // awa snapshot agay la hamu shtakani Function waitForFiveSec
                  //azanet chi akat , la ch mar7alaya
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      //agar error habet awa deta naw snapshot
                      return Text(snapshot.error.toString());
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      //return CircularProgressIndicator();
                      return LinearProgressIndicator();
                    }
                    return Text("Hello");
                  }),
            ),
            Expanded(
              child: Container(
                child: FutureBuilder(
                  future: fetchPostForApp(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.data == null) {
                      return Text('no data');
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            child:
                                Text(snapshot.data![index]["title"].toString()),
                          );
                        });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//sync chaarey baby xoishy nakat
//async chawa akat
  Future waitForFiveSec() async {
    return await Future.delayed(Duration(seconds: 5)).then((value) => true);
  }

//https://jsonplaceholder.typicode.com/posts
  Future<List<Map<String, dynamic>>> fetchPostForApp() async {
    final _apiEndpoint =
        'https://jsonplaceholder.typicode.com/posts'; // varible haya assign aw url krdwa
    http.Response _reponse = await http.get(Uri.parse(_apiEndpoint));
    var _decodeJson =
        json.decode(_reponse.body); // request nardwa bo url alem response bdawa
    List<Map<String, dynamic>> _listOfPosts =
        _decodeJson.cast<Map<String, dynamic>>();
    return _listOfPosts; // labar away lera ba string aigarenmawa boya  type function krdwa String
  }
}
