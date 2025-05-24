import 'package:flutter/material.dart';

class HomePageCnpj extends StatelessWidget {
  const HomePageCnpj({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Página Inicial')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Bem-vindo à Página Inicial!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Adicione a ação do botão aqui
              },
              child: const Text('Clique Aqui'),
            ),
          ],
        ),
      ),
    );
  }
}
