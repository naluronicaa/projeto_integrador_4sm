import 'package:flutter/material.dart';
import 'package:pi4sm/scr/pagina_pesquisa.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Faça seu Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20), // Espaçamento entre o texto e a imagem
                  Icon(Icons.account_circle_sharp, size: 100),
                  SizedBox(height: 20), // Espaçamento entre a imagem e os campos de texto
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10), // Espaçamento entre os campos de texto
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true, // Para esconder a senha
                  ),
                  SizedBox(height: 10), // Espaçamento entre senha e o "Esqueci minha senha"
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // Lógica para "Esqueci minha senha"
                      },
                      child: Text(
                        "Esqueci minha senha",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      //logica de login
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PaginaPrincipal()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF0E3B50), // Cor de fundo azul personalizada (RGB: 14, 59, 80)
                      onPrimary: Colors.white, // Cor do texto em branco
                    ),
                    child: Text('Entrar'),
                  )

                  // Adicione mais coisas aqui
                ],
              ),
            ) 
          ),
        ),
    );
  }
}


