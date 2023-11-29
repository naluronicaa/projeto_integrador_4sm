import 'package:flutter/material.dart';
import 'package:pi4sm/scr/login/login.dart';
import 'package:pi4sm/scr/login/cadastro.dart';

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({super.key});

  @override
  State<PaginaLogin> createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, // aqui define o numero de abas que vao ter
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Login e Cadastro', style: TextStyle(color: Colors.white)),
            backgroundColor: Color(0xFF0E3B50),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(text: 'Login'), // Primeira aba para o login
                Tab(text: 'Cadastro'), // Segunda aba para o cadastro
              ],
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: TabBarView(
            children: [
              const LoginPage(), // Conteúdo da primeira aba (página de login)
              CadastroPage(), // Conteúdo da segunda aba (página de cadastro)
            ],
          ),
        ),
    );
  }
}