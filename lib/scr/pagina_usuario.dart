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
         actions: const <Widget> [
            Text('Car Hunters', style: TextStyle(fontSize: 18, color:Colors.white)),
            SizedBox(width: 10),
            Icon(Icons.account_circle, size: 40),
            SizedBox(width: 10),
         ],
         
         ),
          body: Container(
            color: const Color.fromARGB(255, 237, 235, 235),
            child: Stack(
              children: [
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(50.0),
                    color: const Color.fromARGB(150, 135, 157, 168),
                  ),
                ),
                
                Positioned(
                  top:110,
                  left: 30,
                  right: 30,
                  child: Container(
                    padding: const EdgeInsets.all(80.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Define a cor da sombra
                            blurRadius: 2, // Define o desfoque da sombra
                            offset: const Offset(0,4), // Define o deslocamento da sombra
                          ),
                        ],
                      ),
                  ),
                )

              ],
            ),
          ),
    );
  }
}