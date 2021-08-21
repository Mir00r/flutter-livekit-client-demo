import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();

    getName() {
      print(name.text);
    }

    return Container(
      child: Column(
        children: [
          TextFormField(
            controller: name,
          ),
          IconButton(
              onPressed: () {
                getName();
              },
              icon: Icon(Icons.add))
        ],
      ),
    );
  }
}
