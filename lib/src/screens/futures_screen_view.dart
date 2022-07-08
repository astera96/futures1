import 'package:flutter/material.dart';
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
        child: FutureBuilder(
            future: waitForFiveSec(),
             //context , snapshot amana atwani nawakani bgorit
              // awa snapshot agay la hamu shtakani Function waitForFiveSec
              //azanet chi akat , la ch mar7alaya
            builder: (context, snapshot) {
              if (snapshot.hasError) {    //agar error habet awa deta naw snapshot
                return Text(snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                //return CircularProgressIndicator();
                return LinearProgressIndicator();
              }
              return Text("Hello");
            }),
      ),
    );
  }


//sync chaarey baby xoishy nakat
//async chawa akat
  Future waitForFiveSec() async {
    return await Future.delayed(Duration(seconds: 5)).then((value) => true);
  }
}
