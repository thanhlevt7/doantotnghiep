import 'package:fluter_19pmd/views/test.dart';
import 'package:flutter/material.dart';

import '../repository/invoice_api.dart';

class OpenMomo extends StatefulWidget {
  const OpenMomo({Key key}) : super(key: key);

  @override
  State<OpenMomo> createState() => _OpenMomoState();
}

class _OpenMomoState extends State<OpenMomo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: ()  async{
              var a = await RepositoryInvoice.paymentMomo();
              if (a == 200) {
                print("1");
              }
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const TestMomo()));
            },
            child: const Text("open web")),
      ),
    );
  }
}
