import 'package:flutter/material.dart';
import 'package:bchainhello/contract_linking.dart';
import 'package:provider/provider.dart';

class HomeUI extends StatelessWidget {
  final _data = {
    'product': "NEW ONE",
    'iDate': "20-10-2022",
    'exDate': "20-12-2022",
    'price': 100.0,
    'manf': "ALI PVT",
    'salt': "HYEPERX",
    'docType': "SKINS"
  };

  @override
  Widget build(BuildContext context) {
    // Getting the value and object or contract_linking
    var contractLink = Provider.of<ContractLinking>(context);

    TextEditingController yourNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("DRUXA"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: contractLink.isLoading
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Form(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Last Expiry Date: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 52),
                            ),
                            Text(
                              contractLink.expiryDate,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 52,
                                  color: Color.fromARGB(255, 255, 181, 22)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 29),
                          child: TextFormField(
                            controller: yourNameController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Your Name",
                                hintText: "What is your name ?",
                                icon: Icon(Icons.drive_file_rename_outline)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            child: const Text(
                              'Set Name',
                              style: TextStyle(fontSize: 30),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 255, 181, 22),
                            ),
                            onPressed: () {
                              contractLink.setDrug(_data);
                              yourNameController.clear();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
