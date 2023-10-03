import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pi4sm/scr/pagina_pesquisa.dart';

class CadastroPage extends StatelessWidget {

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  Future<void> cadastrarUsuario(String nome, String email, String senha) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/users'), // Substitua pela URL do seu servidor
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nome': nome,
        'email': email,
        'senha': senha,
      }),
    );

    if (response.statusCode == 200) {
      // Cadastro bem-sucedido
      print('Usuário cadastrado com sucesso');
    } else {
      // Se a requisição falhar, lança uma exceção
      throw Exception('Falha ao cadastrar usuário');
    }
  }


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
                  onPressed: () async {
                    try {
                      await cadastrarUsuario(
                        nomeController.text,
                        emailController.text,
                        senhaController.text,
                      );
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PaginaPrincipal()));
                    } catch (e) {
                      print('Erro ao cadastrar usuário: $e');
                    }
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
