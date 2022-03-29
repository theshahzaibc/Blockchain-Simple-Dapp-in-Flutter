import 'package:flutter/material.dart';
import 'package:bchainhello/contract_linking.dart';
import 'package:bchainhello/ui.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Inserting Provider as a parent of HomeUI()
    return ChangeNotifierProvider<ContractLinking>(
      create: (_) => ContractLinking(),
      child: MaterialApp(
        title: "DRUXA",
        home: HomeUI(),
      ),
    );
  }
}
