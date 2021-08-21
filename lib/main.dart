import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:livekit_client/livekit_client.dart';
import 'room.dart';

void main() {
  // configure logs for debugging
  Logger.root.level = Level.FINE;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LiveKit Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: PreConnect(),
    );
  }
}

TextEditingController url = TextEditingController();
TextEditingController token = TextEditingController();

class PreConnect extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PreConnectState(
      url.text,
      token.text,
    );
  }
}

class _PreConnectState extends State<PreConnect> {
  String urlV;
  String tokenV;

  _PreConnectState(this.urlV, this.tokenV);

  _connect(BuildContext context) async {
    try {
      var room = await LiveKitClient.connect(url.text, token.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return RoomWidget(room);
        }),
      );
    } catch (e) {
      print("could not connect $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect to LiveKit'),
      ),
      body: Center(
        child: Container(
          // width: 250,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'URL',
                ),
                controller: url,
                // onChanged: (value) => this.url,
                // initialValue: this.url,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Token',
                ),
                controller: token,
                // onChanged: (value) => this.token,
                // initialValue: this.token,
              ),
              TextButton(
                onPressed: () => _connect(context),
                child: Text('Connect'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
