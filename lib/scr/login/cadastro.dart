import 'package:flutter/material.dart';

class CadastroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Faça seu Cadastro',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 100), // Espaçamento entre o texto e os campos de texto
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10), // Espaçamento entre os campos de texto
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10), // Espaçamento entre os campos de texto
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true, // Para esconder a senha
                ),
                const SizedBox(height: 10), // Espaçamento entre os campos de texto
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Confirmar Senha',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true, // Para esconder a senha
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Lógica de cadastro
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF0E3B50), // Cor de fundo azul personalizada (RGB: 14, 59, 80)
                    onPrimary: Colors.white, // Cor do texto em branco
                  ),
                  child: const Text('Cadastrar'),
                ),
                // Adicione mais coisas aqui
              ],
            ),
          ),
        ),
    );
  }
}
