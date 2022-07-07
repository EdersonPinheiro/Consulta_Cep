import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController txtcep = TextEditingController(); //Scanner sc
  String resultado = '';

  consultaCep() async {
    String cep = txtcep.text;
    String url = 'https://viacep.com.br/ws/${cep}/json/';

    http.Response response;
    response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno['logradouro'];
    String cidade = retorno['localidade'];
    String bairro = retorno['bairro'];

    setState(() {
      resultado = "${logradouro}, ${bairro}, ${cidade}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Consulta Cep'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              controller: txtcep,
              decoration: InputDecoration(
                labelText: 'CEP',
              ),
            ),
            Text(
              'Resultado : ${resultado}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(surfaceTintColor: Colors.amber),
                onPressed: () {
                  consultaCep();
                },
                child: const Text(
                  'Consultar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
