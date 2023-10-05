import 'package:flutter/material.dart'; 
import 'package:pi4sm/scr/navbar.dart';

class PaginaUsuario extends StatefulWidget {
  const PaginaUsuario({super.key});

  @override
  State<PaginaUsuario> createState() => _PaginaUsuarioState();
}

void _showEditModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const Text('Nome Usuario'),

            const TextField(
              decoration: InputDecoration(labelText: 'Novo Nome'),
            ),

            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Lógica para atualizar o nome
                Navigator.pop(context); // Fechar o modal após a ação
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 15, 59, 80))
              ),
              child: Text('Atualizar Nome', style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 10),

             const Text('Nome Email'),

            const TextField(
              decoration: InputDecoration(labelText: 'Novo Email'),
            ),

            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Lógica para atualizar o nome
                Navigator.pop(context); // Fechar o modal após a ação
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255,15, 59, 80))
              ),
              child: Text('Atualizar Email', style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 10),

             const Text('Nome Senha'),

            const TextField(
              decoration: InputDecoration(labelText: 'Novo Senha'),
            ),

            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Lógica para atualizar o nome
                Navigator.pop(context); // Fechar o modal após a ação
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 15, 59, 80))
              ),
              child: Text('Atualizar Senha', style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Lógica para atualizar o nome
                
                Navigator.pop(context); // Fechar o modal após a ação
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 216, 7, 7))
              ),
              child: Text('Deletar Conta', style: TextStyle(color: Colors.white)),
            ),
            
          ],
        ),
      );
    },
  );
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
                    padding: const EdgeInsets.all(90.0),
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/fundouser.jpeg'), // Substitua pelo caminho da sua imagem
                          fit: BoxFit.cover, // Ajuste de acordo com sua necessidade (cover, contain, etc.)
                        ),
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
                ),

                Positioned(
                  top:130,
                  left: 100,
                  right: 100,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.account_circle, size: 90), // Icone no topo
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Nome do Usuário', style: TextStyle(fontSize: 20)), // Texto abaixo do ícone
                        const SizedBox(height: 10), // Espaço entre o texto e o IconButton
                        IconButton(
                          onPressed: () {
                            _showEditModal(context);
                          },
                          icon: const Icon(Icons.create_rounded),
                          iconSize: 20,
                        ),
                      ],
                    ) // Espaço entre o ícone e o texto
                     // IconButton ao lado do texto
                  ],
                ),
                ),
              ],
            ),
          ),
    );
  }
}