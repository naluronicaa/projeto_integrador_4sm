import 'package:flutter/material.dart';
import 'package:pi4sm/scr/navbar.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => PaginaPrincipalState();
}


class PaginaPrincipalState extends State<PaginaPrincipal> {
  

  List<String> marca = ["Renault", "Fiat", "Toyota", "Ford", "Chevrolet", "Honda", "Hyundai", "Mitsubishi", "Volkswagen", "Outra"];
  List<String> ano = ["2000 - 2005", "2005 - 2010", "2010 - 2020", "acima de 2020"];
  List<String> modelo = ["modelo 1", "modelo 2", "modelo 3"];//terminar
  List<String> km = ["0km - 10000km", "10000km - 20000km", "20000km - 30000km", "50000km - 60000km", "mais que 60000km"];
  List<String> carroceria = ["Buggy", "Conversível", "Cupê", "Hatchback", "Sedâ", "Minivan", "Perua/SW", "Picape", "Esportivo", "Van", "Outra"];
  List<String> cor = ["Preto", "Prata", "Branco", "Vermelho", "Marrom", "Azul", "Amarelo", "Outra"];
  List<String> novoounao = ["Novo", "Seminovo","Usado"];
  List<String> preco = ["caro", "nao caro"];
  List<String> tabelaFIP = ["Comparar", "Não comparar"];
  List<String> loca = ["Próximo a mim", "Qualquer lugar"];
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
  final valorLoca = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavBar(),

      //cabeçalho
       appBar: AppBar(
        title: const Text('Olá, <Nome>!', style: TextStyle(fontSize: 15, color : Colors.white)),
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
      ),

      body: Container(
        color: const Color.fromARGB(255, 237, 235, 235),
        child : Stack(
          children: [
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(25.0),
                color: const Color.fromARGB(150, 135, 157, 168),
                child: const TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Busque seu carro aqui',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    )
                  ),
                )
              ), 
            ),
            
            Positioned(
              top: 220,
              left: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Define a cor da sombra
                      blurRadius: 2, // Define o desfoque da sombra
                      offset: const Offset(0,4), // Define o deslocamento da sombra
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Tooltip(
                      message: 'Resetar Filtros',
                      child: IconButton(
                      onPressed: () {
                        valorMarca.value = '';
                        valorAno.value = '';
                        valorModelo.value = '';
                        valorKM.value = '';
                        valorCarroceria.value = '';
                        valorCor.value = '';
                        valorNov.value = '';
                        valorPreco.value = '';
                        valorTabelaFIP.value = '';
                        valorRelev.value = '';
                        valorLoca.value = '';
                      }, 
                    icon: const Icon(Icons.loop_outlined)),
                    ),

                    //filtro marca
                    Container(
                        padding: const EdgeInsets.all(3.0),
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

                    //filtro Ano
                    Container(
                        padding: const EdgeInsets.all(3.0),
                        child: ValueListenableBuilder(
                          valueListenable: valorAno, builder: (BuildContext constext, String value, _){
                            return DropdownButton<String>(
                              hint: const Text("Ano"),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) => valorAno.value = escolha.toString(),
                              items: ano.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child: Text(opcao),
                              )).toList(),
                            );
                          })
                        
                      ),
                      
                    //filtro Modelo
                    Container(
                        padding: const EdgeInsets.all(3.0),
                        child: ValueListenableBuilder(
                          valueListenable: valorModelo, builder: (BuildContext constext, String value, _){
                            return DropdownButton<String>(
                              hint: const Text("Modelo"),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) => valorModelo.value = escolha.toString(),
                              items: modelo.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child: Text(opcao),
                              )).toList(),
                            );
                          })
                        
                      ),

                    //filtro KM
                    Container(
                        padding: const EdgeInsets.all(3.0),
                        child: ValueListenableBuilder(
                          valueListenable: valorKM, builder: (BuildContext constext, String value, _){
                            return DropdownButton<String>(
                              hint: const Text("Quilometragem"),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) => valorKM.value = escolha.toString(),
                              items: km.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child: Text(opcao),
                              )).toList(),
                            );
                          })
                        
                      ),

                    //filtro Carroceria
                    Container(
                        padding: const EdgeInsets.all(3.0),
                        child: ValueListenableBuilder(
                          valueListenable: valorCarroceria, builder: (BuildContext constext, String value, _){
                            return DropdownButton<String>(
                              hint: const Text("Carroceria"),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) => valorCarroceria.value = escolha.toString(),
                              items: carroceria.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child: Text(opcao),
                              )).toList(),
                            );
                          })
                        
                      ),

                    //filtro cor
                    Container(
                        padding: const EdgeInsets.all(3.0),
                        child: ValueListenableBuilder(
                          valueListenable: valorCor, builder: (BuildContext constext, String value, _){
                            return DropdownButton<String>(
                              hint: const Text("Cor"),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) => valorCor.value = escolha.toString(),
                              items: cor.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child: Text(opcao),
                              )).toList(),
                            );
                          })
                        
                      ),

                      //filtro novo ou não
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        child: ValueListenableBuilder(
                          valueListenable: valorNov, builder: (BuildContext constext, String value, _){
                            return DropdownButton<String>(
                              hint: const Text("Condição"),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) => valorNov.value = escolha.toString(),
                              items: novoounao.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child: Text(opcao),
                              )).toList(),
                            );
                          })
                        
                      ),

                      //filtro preço
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        child: ValueListenableBuilder(
                          valueListenable: valorPreco, builder: (BuildContext constext, String value, _){
                            return DropdownButton<String>(
                              hint: const Text("Preço"),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) => valorPreco.value = escolha.toString(),
                              items: preco.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child: Text(opcao),
                              )).toList(),
                            );
                          })
                        
                      ),

                      //filtro tabelaFIP
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        child: ValueListenableBuilder(
                          valueListenable: valorTabelaFIP, builder: (BuildContext constext, String value, _){
                            return DropdownButton<String>(
                              hint: const Text("Tabela FIP"),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) => valorTabelaFIP.value = escolha.toString(),
                              items: tabelaFIP.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child: Text(opcao),
                              )).toList(),
                            );
                          })
                        
                      ),

                      //filtro localização
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        child: ValueListenableBuilder(
                          valueListenable: valorLoca, builder: (BuildContext constext, String value, _){
                            return DropdownButton<String>(
                              hint: const Text("Localização"),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) => valorLoca.value = escolha.toString(),
                              items: loca.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child: Text(opcao),
                              )).toList(),
                            );
                          })
                        
                      ),

                      //filtro relevancia
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        child: ValueListenableBuilder(
                          valueListenable: valorRelev, builder: (BuildContext constext, String value, _){
                            return DropdownButton<String>(
                              hint: const Text("Relevancia"),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) => valorRelev.value = escolha.toString(),
                              items: relevancia.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child: Text(opcao),
                              )).toList(),
                            );
                          })
                        
                      ),



                  ],
                )
                )
                
                                
              ),
            )
          ],
        ),
      )
    );
  }
}