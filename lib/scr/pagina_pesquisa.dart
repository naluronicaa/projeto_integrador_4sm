import 'package:flutter/material.dart';
import 'package:pi4sm/scr/navbar.dart';
import 'package:pi4sm/scr/ofertas.dart';
import 'package:pi4sm/scr/pagina_usuario.dart';
import 'utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});
  @override
  State<PaginaPrincipal> createState() => PaginaPrincipalState();
}

class PaginaPrincipalState extends State<PaginaPrincipal> {
  List<String> marca = ["Renault", "Fiat", "Toyota", "Ford", "Chevrolet", "Honda", "Hyundai", "Mitsubishi", "Volkswagen", "Outra"];
  List<String> ano = ["abaixo de 2000","2000 - 2005", "2005 - 2010", "2010 - 2020", "acima de 2020"];

  Map<String, Map<String, int>> intervalosAno = {
    "abaixo de 2000": {"min": 0, "max": 2000},
    "2000 - 2005": {"min": 2000, "max": 2005},
    "2005 - 2010": {"min": 2005, "max": 2010},
    "2010 - 2020": {"min": 2010, "max": 2020},
    "acima de 2020": {"min": 2020, "max": 2050},
  };

  Map<String, List<String>> modelosPorMarca = {
  "Renault":["Kwid", "Stepway", "Logan",  "Captur", "Duster", "Oroch", "Sandero", "Outro"],
  "Fiat": ["Uno", "Mobi", "Argo", " Toro", "Strada", "Palio", "Siena", "Cronos", "Outro"],
  "Toyota" : ["Corolla", "Hilux", "Etios", "Yaris", "RAV4", "SW4", "Prius", "Sequoia", "Outro"],
  "Ford" : ["Ka", "Fiesta", "Focus", "EcoSport", "Fusion", "Ranger", "Edge", "Mustang", "Outro"],
  "Chevrolet" : ["Onix", "Prisma", "Cobalt", "Corsa", "Tracker", "Cruze", "Equinox", "S10", "Outro"],
  "Honda" : ["Civic", "Fit", "HR-V", "City", "CR-V","WR-V","Accord", "Insight", "Outro"],
  "Hyundai" :  ["HB20", "Creta", "Tucson", "Santa Fe", "ix35", "Veloster", "Elantra", "Outro"],
  "Mitsubishi" : ["Lancer", "ASX", "Outlander", "Pajero", "Eclipse Cross", "Outro"],
  "Volkswagen" : ["Gol", "Polo", "Virtus", "Jetta", "Voyage", "Fox", "Golf", "Saveiro", "Amarok", "Outro"],
  "Outra" : ["Outros"]
  };

  List<String> km = ["abaixo 10.000", "10.000 - 20.000", "20.000 - 30.000", "50.000 - 60.000", "acima de 60.000"];
  Map<String, Map<String, double>> intervalosKM = {
    "abaixo 10.000": {"min": 0, "max": 10.000},
    "10.000 - 20.000": {"min": 10.000, "max": 20.000},
    "20.000 - 30.000": {"min": 20.000, "max": 30.000},
    "50.000 - 60.000": {"min": 50.000, "max": 60.000},
    "acima de 60.000": {"min": 60.000, "max": 10000000},
  };

  List<String> carroceria = ["Buggy", "Conversível", "Cupê", "Hatchback", "Sedan", "Minivan", "Perua", "Picape", "Esportivo", "Van", "Outra"];
  List<String> cor = ["Preto", "Prata", "Branco", "Vermelho", "Marrom", "Azul", "Amarelo", "Outra"];
  List<String> novoounao = ["Novo", "Seminovo","Usado"];
  List<String> preco = ["abaixo de 10000", "10000 - 20000", "20000 - 30000", "30000 - 40000",
   "40000 - 50000", "50000 - 60000", "60000 - 70000", "70000 - 80000", "80000 - 90000", "acima de 90000"];

  Map<String, Map<String, int>> intervalosPreco = {
    "abaixo de 10000": {"min": 0, "max": 10000},
    "10000 - 20000": {"min": 10000, "max": 20000},
    "20000 - 30000": {"min": 20000, "max": 30000},
    "30000 - 40000": {"min": 30000, "max": 40000},
    "40000 - 50000": {"min": 40000, "max": 50000},
    "50000 - 60000": {"min": 50000, "max": 60000},
    "60000 - 70000": {"min": 60000, "max": 70000},
    "70000 - 80000": {"min": 70000, "max": 80000},
    "80000 - 90000": {"min": 80000, "max": 90000},
    "acima de 90000": {"min": 90000, "max": 10000000},
  };


  List<String> relevancia =["Maior Preço", "Menor Preço", "Maior KM", "Menor KM"];

  List<String> localF = ['AC - Acre', 'AL - Alagoas', 'AP - Amapá', 'AM - Amazonas', 'BA - Bahia', 'CE - Ceará', 'DF - Distrito Federal', 'ES - Espírito Santo', 'GO - Goiás', 'MA - Maranhão', 'MT - Mato Grosso', 'MS - Mato Grosso do Sul', 'MG - Minas Gerais', 'PA - Pará', 'PB - Paraíba', 'PR - Paraná', 'PE - Pernambuco', 'PI - Piauí', 'RJ - Rio de Janeiro', 'RN - Rio Grande do Norte', 'RS - Rio Grande do Sul', 'RO - Rondônia', 'RR - Roraima', 'SC - Santa Catarina', 'SP - São Paulo', 'SE - Sergipe', 'TO - Tocantins'];


  Map<String, String> filtros = {};
  Map<String, dynamic> filtrosIntervalos = {};

  void atualizarFiltro(String nome, String valor) {
    setState(() {
      filtros[nome] = valor;
    });
  }

  void atualizarFiltroIntervalos(String nome, dynamic valor1, dynamic valor2) {
    setState(() {
      filtrosIntervalos[nome] = {'min': valor1, 'max': valor2};
    });
  }

  void refreshFiltros() {
    setState(() {
      valorMarca.value = '';
      valorModelo.value = '';
      valorAno.value = '';
      valorKM.value = '';
      valorCarroceria.value = '';
      valorCor.value = '';
      valorNov.value = '';
      valorPreco.value = '';
      valorRelev.value = '';
      valorLocal.value = '';
      termo.value = '';
      filtros.clear();
      filtrosIntervalos.clear();
    });

    fetchCarros(termo.value, filtros, filtrosIntervalos, valorRelev.value);
  }
  
  void mostrarPopup(BuildContext context) async {
    bool popupJaExibido = await obterPopupExibido();

    if (!popupJaExibido) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Row(
              children: [
                Text("Você tem 10\nmoedas do CarHunters!", style: TextStyle(color: Color.fromARGB(255, 15, 59, 80), fontSize: 20)),
                SizedBox(width: 20),
                Image.asset('assets/coin.png', width: 50, height: 50), 
                
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 15, 59, 80), // Defina a cor do botão aqui
                ),
                child: Text('OK', style: TextStyle(color: Colors.white),),
              ),
            ],
          );
        },
      );
      await setPopupExibido(true);
    }
  }

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
  final valorLocal = ValueNotifier('');
  final termo = ValueNotifier('');

  final TextEditingController searchController = TextEditingController();
  final ScrollController controleDeFIltros = ScrollController();
  final ScrollController controleDeAnuncios = ScrollController();

  Future<List<CarroWidget>> fetchCarros(String termo, filtros, filtrosIntervalos, relev) async {
    var url = Uri.parse("http://localhost:3001/carrosFiltrados?termo=$termo&filtros=${jsonEncode(filtros)}&filtrosIntervalos=${jsonEncode(filtrosIntervalos)}&relevancia=$relev");
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<CarroWidget> carros = jsonList.map((json) => CarroWidget.fromJson(json)).toList();
        return carros;
      } else {
        throw Exception('Falha ao carregar carros');
      }
    } catch (error){
      var url = Uri.parse("http://10.2.130.76:3001/carrosFiltrados?termo=$termo&filtros=${jsonEncode(filtros)}&filtrosIntervalos=${jsonEncode(filtrosIntervalos)}&relevancia=$relev");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<CarroWidget> carros = jsonList.map((json) => CarroWidget.fromJson(json)).toList();
        return carros;
      } else {
        throw Exception('Falha ao carregar carros');
      }
    }
  }


  
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      mostrarPopup(context);
    });
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavBar(),
      //cabeçalho
       appBar: AppBar(
        title: const Text('Olá!', style: TextStyle(fontSize: 15, color : Colors.white)),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PaginaUsuario()));
            }, 
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
            //exibição dos produtos
           Positioned(
            top: 180,
            left: 25,
            right: 25,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.center,
              child: FutureBuilder<List<CarroWidget>>(
                future: fetchCarros(termo.value, filtros, filtrosIntervalos, valorRelev.value),
                builder: (BuildContext context, AsyncSnapshot<List<CarroWidget>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); 
                  } else if (snapshot.hasError) {
                    return Text('Erro ao carregar carros: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return const Text('Nenhum carro foi encontrado 😟');
                  } else {
                    List<CarroWidget> carros = snapshot.data!;
                    return ListView.separated(
                      itemCount: carros.length,
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15),
                      itemBuilder: (BuildContext context, int index) {
                        return carros[index]; 
                      },
                    );
                  }
                },
              ),
            ),
          ),


            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(95.0),
                color: const Color.fromARGB(255, 237, 235, 235),
              ),
            ),

            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(30.0),
                color: const Color.fromARGB(150, 135, 157, 168),
                child: TextField(
                  controller: searchController,
                  onSubmitted: (String value) {
                    setState(() {
                      termo.value = value.toString();
                    });
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Digite a marca, modelo, ano, cor ou/e carroceria',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
            ),
            
            //filtros
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
                      color: Colors.grey.withOpacity(0.5), 
                      blurRadius: 2, 
                      offset: const Offset(0,4),
                    ),
                  ],
                ),
                child: Scrollbar(
                controller: controleDeFIltros,
                
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: controleDeFIltros,

                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //resetar filtros
                    Tooltip(
                      message: 'Resetar Filtros',
                      child: IconButton(
                      onPressed: () {
                        refreshFiltros();
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
                              onChanged: (escolha) {
                                valorModelo.value = '';
                                valorMarca.value = escolha.toString();
                                atualizarFiltro("marca", escolha.toString());
                              },
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
                              onChanged: (escolha) {
                                valorAno.value = escolha.toString();
                                
                                int? minAno = intervalosAno[escolha]!["min"];
                                int? maxAno = intervalosAno[escolha]!["max"];

                                atualizarFiltroIntervalos("ano", minAno, maxAno);
                              },
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
                        valueListenable: valorMarca, 
                        builder: (BuildContext context, String marcaSelecionada, _) {
                          
                          //a lista de modelos correspondente à marca selecionada
                          List<String> modelos = modelosPorMarca[marcaSelecionada] ?? [];

                          return DropdownButton<String>(
                            hint: const Text("Modelo"),
                            value: (valorModelo.value.isEmpty) ? null : valorModelo.value,
                            onChanged: (escolha) {
                              valorModelo.value = escolha.toString();
                              atualizarFiltro('modelo', escolha.toString());
                            },
                            
                            items: modelos.map((opcao) => DropdownMenuItem(
                              value: opcao,
                              child: Text(opcao),
                            )).toList(),
                          );
                        }
                      ),
                    ),


                    //filtro KM
                    Container(
                        padding: const EdgeInsets.all(3.0),
                        child: ValueListenableBuilder(
                          valueListenable: valorKM, builder: (BuildContext constext, String value, _){
                            return DropdownButton<String>(
                              hint: const Text("Quilometragem"),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) {
                                valorKM.value = escolha.toString();
                                double? minKM = intervalosKM[escolha]!["min"];
                                double? maxKM = intervalosKM[escolha]!["max"];

                                atualizarFiltroIntervalos('km', minKM, maxKM);
                              },
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
                              onChanged: (escolha) {
                                valorCarroceria.value = escolha.toString();
                                atualizarFiltro('carroceria', escolha.toString());
                              },
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
                              onChanged: (escolha) {
                                valorCor.value = escolha.toString();
                                atualizarFiltro('cor', escolha.toString());
                              },
                              items: cor.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child: Text(opcao),
                              )).toList(),
                            );
                          })
                      ),

                     //filtro condição
                    Container(
                        padding: const EdgeInsets.all(3.0),
                        child: ValueListenableBuilder(
                          valueListenable: valorNov, builder: (BuildContext constext, String value, _){
                            return DropdownButton<String>(
                              hint: const Text("Condição"),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) {
                                valorNov.value = escolha.toString();
                                atualizarFiltro('condicao', escolha.toString());
                              },
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
                              onChanged: (escolha) {
                                valorPreco.value = escolha.toString();

                                int? minP = intervalosPreco[escolha]!["min"];
                                int? maxP = intervalosPreco[escolha]!["max"];

                                atualizarFiltroIntervalos("preco", minP, maxP);
                              },
                              items: preco.map((opcao) => DropdownMenuItem(
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
                          valueListenable: valorLocal, builder: (BuildContext constext, String value, _){
                            return DropdownButton<String>(
                              hint: const Text("Localização"),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) {
                                valorLocal.value = escolha.toString();
                                atualizarFiltro('localizacaoM', escolha.toString().substring(0,2));
                              },
                              items: localF.map((opcao) => DropdownMenuItem(
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
                              onChanged: (escolha) {
                                setState(() {
                                   valorRelev.value = escolha.toString();
                                });
                              },
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
            ),
          ],
        ),
      )
    );
  }
}