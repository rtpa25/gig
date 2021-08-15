import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tik_tok_ui/constant/data.dart';
import '../widgets/status.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Status'),
        ),
        body: ListView.builder(itemBuilder: (context, index) {
          return StatusCircle(
            imageUrl: Provider.of<Data>(context).following[index]['image'],
            name: Provider.of<Data>(context).following[index]['name'],
            timestamp: Provider.of<Data>(context).following[index]['time'],
          );
        }),
      ),
    );
  }
}
