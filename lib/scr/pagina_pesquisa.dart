import 'package:flutter/material.dart';
import 'package:pi4sm/scr/navbar.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => PaginaPrincipalState();
}

class PaginaPrincipalState extends State<PaginaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavBar(),
      //cabeçalho
      appBar: AppBar(
        title: const Text('Olá!', style: TextStyle(fontSize: 18, color : Colors.white)),
        actions: <Widget>[
          IconButton(
            onPressed: () {}, 
            icon: const Row(
            children: <Widget>[
              Icon(Icons.star, color: Color.fromARGB(255, 223, 173, 44)),
              SizedBox(width: 5), // Espaçamento entre o ícone e o texto
              Text('Favoritos', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Image.asset('assets/logo_HOC.png', width: 60, height: 60),
          const SizedBox(width: 20),
        ],
        backgroundColor: Color.fromARGB(255, 15, 59, 80),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15)
          )
        ),
        toolbarHeight: 100,
        iconTheme: IconThemeData(color: Colors.white),
      ),

      
    );
  }
}