import 'package:flutter/material.dart';
import 'package:pi4sm/scr/navbar.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => PaginaPrincipalState();
}

class PaginaPrincipalState extends State<PaginaPrincipal> {
  List<String> marca = ["Renault", "Fiat", "Toyota", "Ford", "Chevrolet", "Honda", "Hyundai", "Mitsubishi", "Volkswagen"];
  List<String> ano = ["2000 - 2005", "2005 - 2010", "2010 - 2020", "< 2020"];
  List<String>  modelo = ["modelo 1", "modelo 2", "modelo 3"];
  List<String> km = ["0km - 10000km", "10000km - 20000km", "20000km - 30000km", "50000km - 60000km", "< 60000km"];
  List<String> carroceria = ["Buggy", "Conversível", "Cupê", "Hatchback", "Sedâ", "Minivan", "Perua/SW", "Picape", "Esportivo", "Van"];
  List<String> cor = ["Preto", "Prata", "Branco", "Vermelho", "Marrom", "Azul", "Amarelo", "Outra"];
  List<String> novoounao = ["novo", "usado"];
  List<String> preco = ["caro", "nao caro"];
  List<String> tabelaFIP = ["Comparar", "não comparar"];
  List<String> relevancia = ["Mais Relevantes", "Maior Preço", "Menor Preço", "Menor KM"];

  final valorMarca = ValueNotifier('');
  final valorAno = ValueNotifier('');
  final valorModelo = ValueNotifier('');
  final valorKM = ValueNotifier('');
  final valorCarroceria = ValueNotifier('');
  final valorCor = ValueNotifier('');
  final valorNov = ValueNotifier('');
  final valorPreco = ValueNotifier('');
  final valorTabelaFIP = ValueNotifier('');
  final valorRelev = ValueNotifier('');

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
        backgroundColor: const Color.fromARGB(255, 15, 59, 80),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15)
          )
        ),
        toolbarHeight: 110,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        bottom:  PreferredSize(
          preferredSize: const Size(500,60),
          child: Column(
            children: <Widget> [
              Container(
                height: 20,
                color : Colors.white.withOpacity(0.5),
              ),
              Container(
                height: 60,
                color: Colors.white.withOpacity(0.5),
                child : Padding(
                  padding: const EdgeInsets.all(7),
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(15),
                      color : Colors.white
                    ),
                    child : TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Busque seu carro aqui!",
                        hintStyle: TextStyle(fontSize:15)
                      ),
                    )
                  )
                )
              ),
              Container(
                height: 20,
                color : Colors.white.withOpacity(0.5),
              )
            ],
          )
        ),
      ),
      body: Stack(
        children: [
         Container(
              height: 180,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(0.0),
                        child: ValueListenableBuilder(
                          valueListenable: valorMarca, builder: (BuildContext constext, String value, _){
                            return DropdownButton<String>(
                              hint: const Text("Marca"),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) => valorMarca.value = escolha.toString(),
                              items: marca.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child: Text(opcao),
                              )).toList(),
                            );
                          })
                        
                      ),
                    ],
                  ),

                ],
                )
            ),
        ],
      ),
      
    );
  }
}