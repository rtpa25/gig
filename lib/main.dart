import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tik_tok_ui/pages/root_app.dart';

import 'constant/data.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Data(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF000000),
          scaffoldBackgroundColor: Color(0xFF000000),
        ),
        home: RootApp(),
      ),
    ),
  );
}
