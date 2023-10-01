import 'package:flutter/material.dart'; 

import 'package:pi4sm/scr/navbar.dart';

class PaginaUsuario extends StatefulWidget {
  const PaginaUsuario({super.key});

  @override
  State<PaginaUsuario> createState() => _PaginaUsuarioState();
}

class _PaginaUsuarioState extends State<PaginaUsuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavBar(),
      appBar: AppBar(
         title: const Text('Minhas informações', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
         backgroundColor: const Color.fromARGB(255, 15, 59, 80),
         shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15)
          )
         ),
         iconTheme: const IconThemeData(color: Colors.white),
         toolbarHeight: 110,
         actions: <Widget> [
            IconButton(
              onPressed: () => null,
              icon: const Row(children: [
                Text('Car Hunters', style: TextStyle(fontSize: 18,color: Colors.white),),
                SizedBox(width: 20),
                Icon(Icons.account_circle, size: 40),
                SizedBox(width: 20)
              ],)
              ),
            
         ],
         
         ),
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(32),
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/fundo.png'),fit: BoxFit.cover)
            ),
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                child: Image.asset('assets/fundouser.jpeg'),
              )
            ),
          ),
    );
  }
}