import 'package:flutter/material.dart';
import 'package:pi4sm/scr/pagina_inicial.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math' as math;
import 'package:pi4sm/scr/usuarios.dart';

class PaginaADM extends StatefulWidget {
  const PaginaADM({super.key});

  @override
  State<PaginaADM> createState() => _PaginaADMState();
}

class _PaginaADMState extends State<PaginaADM> {

  Future<List<UserWidget>> fetchUsuarios() async {
    var url = Uri.parse("http://localhost:3001/usuarios");
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body)['usuarios'];
        List<UserWidget> usuarios = jsonList.map((json) => UserWidget.fromJson(json)).toList();
        return usuarios;
      } else {
        throw Exception('Falha ao carregar usuários');
      }
    } catch (error) {
      var url = Uri.parse("http:///10.2.130.76:3001/usuarios");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body)['usuarios'];
        List<UserWidget> usuarios = jsonList.map((json) => UserWidget.fromJson(json)).toList();
        return usuarios;
      } else {
        throw Exception('Falha ao carregar usuários');
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Administração', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
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
        leading: IconButton(
          icon: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: const Icon(Icons.exit_to_app),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PaginaInicial()));
          },
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 237, 235, 235),
        child: Stack(
          children: [
            Positioned(
              top: 310,
              left: 50,
              right: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Coluna de Sites Cadastrados
                  Container(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "Sites Cadastrados:",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 15, 59, 80)),
                        ),
                        const SizedBox(height: 5),
                        Image.asset("assets/logo_icarros.png", width: 100, height: 55),
                        const SizedBox(height: 5),
                        Image.asset("assets/logo_mercado.png", width: 100, height: 55),
                        const SizedBox(height: 5),
                        Image.asset("assets/logo_olx.png", width: 100, height: 55),
                        const SizedBox(height: 5),
                        Image.asset("assets/logo_webm.png", width: 100, height: 55),
                        const SizedBox(height: 10)
                      ],
                    ),
                  ),
                  const SizedBox(width: 25),

                  // Coluna de Usuários Cadastrados
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Usuários Cadastrados",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 15, 59, 80)),
                        ),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            child: FutureBuilder<List<UserWidget>>(
                              future: fetchUsuarios(),
                              builder: (BuildContext context, AsyncSnapshot<List<UserWidget>> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Erro ao carregar usuários: ${snapshot.error}');
                                } else if (!snapshot.hasData) {
                                  return const Text('Não existem cadastros 😟');
                                } else {
                                  List<UserWidget> usuarios = snapshot.data!;
                                  return ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: usuarios.length,
                                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15),
                                    itemBuilder: (BuildContext context, int index) {
                                      return usuarios[index];
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

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
                    image: AssetImage('assets/fundouser.jpeg'),
                    fit: BoxFit.cover, 
                  ),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 2, 
                      offset: const Offset(0,4),
                    ),
                  ],
                ),
              ),
            ),

            const Positioned(
              top:130,
              left: 100,
              right: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 8),
                  Icon(Icons.car_repair_rounded, size: 90), // Icone no topo
                  SizedBox(height: 5),
                  Text("Car Hunters", style: TextStyle(fontSize: 20), textAlign: TextAlign.center)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
