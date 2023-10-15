import 'package:flutter/material.dart';
import 'package:pi4sm/scr/navbar.dart';
import 'package:pi4sm/scr/ofertas.dart';
import 'package:pi4sm/scr/pagina_usuario.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});
  @override
  State<PaginaPrincipal> createState() => PaginaPrincipalState();
}

class PaginaPrincipalState extends State<PaginaPrincipal> {
  List<String> marca = ["Renault", "Fiat", "Toyota", "Ford", "Chevrolet", "Honda", "Hyundai", "Mitsubishi", "Volkswagen", "Outra"];
  List<String> ano = ["abaixo de 2000","2000 - 2005", "2005 - 2010", "2010 - 2020", "acima de 2020"];
  
  Map<String, List<String>> modelosPorMarca = {
  "Renault":["Kwid", "Stepway", "Logan",  "Captur", "Duster", "Oroch", "Sandero", "Outro"],
  "Fiat": ["Uno", "Mobi", "Argo", " Toro", "Strada", "Palio", "Siena", "Cronos", "Outro"],
  'Toyota' : ["Corolla", "Hilux", "Etios", "Yaris", "RAV4", "SW4", "Prius", "Sequoia", "Outro"],
  'Ford' : ["Ka", "Fiesta", "Focus", "EcoSport", "Fusion", "Ranger", "Edge", "Mustang", "Outro"],
  'Chevrolet' : ["Onix", "Prisma", "Cobalt", "Corsa", "Tracker", "Cruze", "Equinox", "S10", "Outro"],
  'Honda' : ["Civic", "Fit", "HR-V", 'City', 'CR-V','WR-V','Accord', 'Insight', 'Outro'],
  'Hyundai' :  ['HB20', 'Creta', 'Tucson', 'Santa Fe', 'ix35', 'Veloster', 'Elantra', 'Outro'],
  'Mitsubishi' : ['Lancer', 'ASX', 'Outlander', 'Pajero', 'Eclipse Cross', 'Outro'],
  'Volkswagen' : ['Gol', 'Polo', 'Virtus', 'Jetta', 'Voyage', 'Fox', 'Golf', 'Saveiro', 'Amarok', 'Outro'],
  'Outra' : ['Outros']
  };

  List<String> km = ["0km - 10000km", "10000km - 20000km", "20000km - 30000km", "50000km - 60000km", "mais que 60000km"];
  List<String> carroceria = ["Buggy", "Conversível", "Cupê", "Hatchback", "Sedan", "Minivan", "Perua", "Picape", "Esportivo", "Van", "Outra"];
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

  //exemplo de carros sem puxar do banco pq eu preciso testar essa bagaça
  List<CarroWidget> listaDeCarros = [
    //exemplos, trocar depois pela conexão com o Banco de Dados
                  CarroWidget(
                    marca: 'Ford',
                    modelo: 'Fiesta',
                    cor: 'Preto',
                    ano: '2019',
                    preco: 'R\$35.000,00',
                    km: '30.000',
                    localizacao: 'São Paulo - SP',
                    carroceria: 'Hatchback',
                    condicao: 'Usado',
                    fipe: 'R\$37.000,00',
                    site: 'https://www.webmotors.com.br/carros/estoque?lkid=1022',
                  ),

                  CarroWidget(
                    marca: 'Chevrolet',
                    modelo: 'Onix',
                    cor: 'Branco',
                    ano: '2020',
                    preco: 'R\$40.000,00',
                    km: '25.000',
                    localizacao: 'Rio de Janeiro - RJ',
                    carroceria: 'Sedan',
                    condicao: 'Seminovo',
                    fipe: 'R\$42.000,00',
                    site: 'https://www.olx.com.br/',
                  ),

                  CarroWidget(
                    marca: 'Volkswagen',
                    modelo: 'Golf',
                    cor: 'Azul',
                    ano: '2018',
                    preco: 'R\$45.000,00',
                    km: '35.000',
                    localizacao: 'Belo Horizonte - MG',
                    carroceria: 'Hatchback',
                    condicao: 'Usado',
                    fipe: 'R\$47.000,00',
                    site: 'https://www.icarros.com.br/',
                  ),

                  CarroWidget(
                    marca: 'Toyota',
                    modelo: 'Corolla',
                    cor: 'Prata',
                    ano: '2021',
                    preco: 'R\$60.000,00',
                    km: '10.000',
                    localizacao: 'Curitiba - PR',
                    carroceria: 'Sedan',
                    condicao: 'Novo',
                    fipe: 'R\$65.000,00',
                    site: 'https://www.webmotors.com.br/carros/estoque?lkid=1022',
                  ),

                  CarroWidget(
                    marca: 'Honda',
                    modelo: 'Civic',
                    cor: 'Cinza',
                    ano: '2017',
                    preco: 'R\$38.000,00',
                    km: '40.000',
                    localizacao: 'Porto Alegre - RS',
                    carroceria: 'Sedan',
                    condicao: 'Usado',
                    fipe: 'R\$40.000,00',
                    site: 'https://www.olx.com.br/',
                  ),

                  CarroWidget(
                    marca: 'Hyundai',
                    modelo: 'HB20',
                    cor: 'Vermelho',
                    ano: '2019',
                    preco: 'R\$36.000,00',
                    km: '20.000',
                    localizacao: 'Salvador - BA',
                    carroceria: 'Hatchback',
                    condicao: 'Seminovo',
                    fipe: 'R\$38.000,00',
                    site: 'https://www.icarros.com.br/',
                  ),

  ];

  List<CarroWidget> carrosExibidos = [];

  void atualizarLista() {
    carrosExibidos = listaDeCarros.where((carro) {
      bool marcaFiltrada = valorMarca.value.isEmpty || valorMarca.value == carro.marca;
      bool modeloFiltrado = valorModelo.value.isEmpty || valorModelo.value == carro.modelo;
      bool carroceriaFiltrada = valorCarroceria.value.isEmpty || valorCarroceria.value == carro.carroceria;
      bool corFiltrada = valorCor.value.isEmpty || valorCor.value == carro.cor;
      bool condicaoFiltrada = valorNov.value.isEmpty || valorNov.value == carro.condicao;
      
      return marcaFiltrada && modeloFiltrado && carroceriaFiltrada && corFiltrada && condicaoFiltrada;
    }).toList();

    setState(() {}); // Atualiza a UI
  }


  final ScrollController controleDeFIltros = ScrollController();
  final ScrollController controleDeAnuncios = ScrollController();

  @override
    void initState() {
      super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        atualizarLista();
      });
    }


  Widget build(BuildContext context) {
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
                child: ListView(
                  children: (carrosExibidos.isNotEmpty 
                    ? carrosExibidos.map((carro) => carro).toList() 
                    : [const Text("Nenhum veículo foi encontrado")]
                  ),
                ),
                alignment: Alignment.center,
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
                    Tooltip(
                      message: 'Resetar Filtros',
                      child: IconButton(
                      onPressed: () {
                        valorMarca.value = '';
                        valorModelo.value = '';
                        valorAno.value = '';
                        valorKM.value = '';
                        valorCarroceria.value = '';
                        valorCor.value = '';
                        valorNov.value = '';
                        valorPreco.value = '';
                        valorRelev.value = '';
                        valorLoca.value = '';

                        atualizarLista();
                        
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
                                atualizarLista();
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
                                atualizarLista();
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
                              atualizarLista();
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
                              onChanged: (escolha) {
                                valorCarroceria.value = escolha.toString();
                                atualizarLista();
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
                                atualizarLista();
                              },
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
                              onChanged: (escolha) {
                                valorNov.value = escolha.toString();
                                atualizarLista();
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
                              onChanged: (escolha) => valorPreco.value = escolha.toString(),
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
            ),
          
            

          ],
        ),
      )
    );
  }
}