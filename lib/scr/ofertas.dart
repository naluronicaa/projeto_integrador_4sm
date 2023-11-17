import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:convert';

class CarroWidget extends StatefulWidget {
  final String marca;
  final String modelo;
  final String cor;
  final int ano;
  final String km;
  final String localizacao;
  final String carroceria;
  final String condicao;
  final String fipe;
  final String site;
  final String precoM;
  final String? imagemBase64; 

  CarroWidget({
    required this.marca,
    required this.modelo,
    required this.cor,
    required this.ano,
    required this.km,
    required this.localizacao,
    required this.carroceria,
    required this.condicao,
    required this.fipe,
    required this.site,
    required this.precoM,
    this.imagemBase64,
});

  factory CarroWidget.fromJson(Map<String, dynamic> json) {
    return CarroWidget(
      marca: json['marca'],
      modelo: json['modelo'],
      cor: json['cor'],
      ano: json['ano'],
      km: json['kmM'],
      localizacao: json['localizacao'],
      carroceria: json['carroceria'],
      condicao: json['condicao'],
      fipe: json['tabelaFipe'],
      site: json['site'],
      precoM: json['precoM'],
      imagemBase64: json['imagem'],
    );
  }

  @override
  _CarroWidgetState createState() => _CarroWidgetState();
}


class _CarroWidgetState extends State<CarroWidget> {
  bool click = false;

  Widget buildLogo() {
  if (widget.site.contains('webmotors')) {
    // logo da Webmotors
    return Image.asset('assets/logo_webm.png', width: 50, height: 50); // Substitua pelo caminho do seu logo da Webmotors
  } else if (widget.site.contains('olx')) {
    // logo da OLX
    return Image.asset('assets/logo_olx.png', width: 50, height: 50); // Substitua pelo caminho do seu logo da OLX
  } else if (widget.site.contains('icarros')) {
    // logo da iCarros
    return Image.asset('assets/logo_icarros.png', width: 50, height: 50); // Substitua pelo caminho do seu logo da iCarros
  } else if (widget.site.contains('mercadolivre')){
    // logo Mercado livre
    return Image.asset('assets/logo_mercado.png', width: 50, height: 50); // Substitua pelo caminho do seu logo padrão
  } else {
    return Image.asset('assets/logo_HOC.png', width: 50, height: 50);
  }
}


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      final bool isMobile = constraints.maxWidth < 600;
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
              BoxShadow(
              color: Colors.grey.withOpacity(0.5), 
              blurRadius: 2, 
              offset: const Offset(0,4),
            ),
          ],
        ),
        child: isMobile ? 
          Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: widget.imagemBase64 != null
                  ? Image.memory(
                      base64Decode(widget.imagemBase64!),
                      width: 40,
                      height: 115,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/car_default.png',
                      width: 40,
                      height: 115,
                      fit: BoxFit.cover,
                    ),
            ),


            const SizedBox(width: 5),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(widget.modelo + ' \n' + widget.marca, style: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 30, 30, 30))),
                const SizedBox(height: 2),
                Text(widget.precoM, style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 30, 30, 30))),
                const SizedBox(height: 2),
                Text('FIPE: ' + widget.fipe, style: const TextStyle(fontSize: 10, color: Color.fromARGB(130, 30, 30, 30))),
                const SizedBox(height: 2),
                Text(widget.cor + ' ' +  widget.carroceria + ' \n' + widget.condicao +  ' ' + widget.ano.toString() + ' ' + widget.km.toString() + ' km', style: TextStyle(fontSize: 8, color: Color.fromARGB(130, 30, 30, 30))),
              ],
            ),

            const SizedBox(width: 15),

            Column(
              children: [
                Row(
                  children: [
                    buildLogo(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          click = !click;
                        });
                      },
                      icon: Icon((click == true) ? Icons.star : Icons.star_border, color:Color.fromARGB(255, 223, 173, 44)),
                    )
                  ],
                ),

                Text(widget.localizacao, style: TextStyle(fontSize: 10, color: Color.fromARGB(130, 30, 30, 30))),

                ElevatedButton(
                  onPressed: () async {
                     await launchUrlString(widget.site);
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(15, 30)),
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 15, 59, 80)), 
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: const Text('Ver Oferta!', style: TextStyle(color: Colors.white)),
                )
              ],
              
            )
          ],
        ) :
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: widget.imagemBase64 != null
                  ? Image.memory(
                      base64Decode(widget.imagemBase64!),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/car_default.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
            ),

            //primeria parte (marca, modelo, preço, tabela FIPE)
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //nome = Modelo + Marca
                const SizedBox(height: 4),
                Text(widget.modelo + ' ' + widget.marca, style: const TextStyle(fontSize: 17, color: Color.fromARGB(255, 30, 30, 30))),
                const SizedBox(height: 2),
                Text(widget.precoM, style: const TextStyle(fontSize: 17, color: Color.fromARGB(255, 30, 30, 30))),
                const SizedBox(height: 2),
                Text('FIPE ' + widget.fipe, style: const TextStyle(fontSize: 15, color: Color.fromARGB(130, 30, 30, 30)))
              ],
            ),

            //segunda parte (ano, quilometro, local da venda)
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 4),
                Text(widget.ano.toString(), style: const TextStyle(fontSize: 15, color: Color.fromARGB(130, 30, 30, 30))),
                const SizedBox(height: 2),
                Text(widget.km.toString() + ' km', style: const TextStyle(fontSize: 15, color: Color.fromARGB(130, 30, 30, 30))),
                const SizedBox(height: 2),
                Text(widget.localizacao, style: const TextStyle(fontSize: 15, color: Color.fromARGB(130, 30, 30, 30)))
              ],
            ),

            //terceira parte (cor, carroceria, condição do carro)
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 4),
                Text(widget.cor, style: const TextStyle(fontSize: 15, color: Color.fromARGB(130, 30, 30, 30))),
                const SizedBox(height: 2),
                Text(widget.carroceria, style: const TextStyle(fontSize: 15, color: Color.fromARGB(130, 30, 30, 30))),
                const SizedBox(height: 2),
                Text(widget.condicao, style: const TextStyle(fontSize: 15, color: Color.fromARGB(130, 30, 30, 30)))
              ],
            ),
            const SizedBox(width: 12),

            //quarta parte (logo da empresa, favoritos e botão para levar para o site)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    buildLogo(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          click = !click;
                        });
                      },
                      icon: Icon((click == true) ? Icons.star : Icons.star_border, color:const Color.fromARGB(255, 223, 173, 44)),
                    )
                  ],
                ),

                ElevatedButton(
                  onPressed: () async {
                    await launchUrlString(widget.site);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 15, 59, 80)), 
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: const Text('Ver Oferta!', style: TextStyle(color: Colors.white)),
                )
              ],
              
            ),
            const SizedBox(width: 5)                
          ],
        )
      );
    }
    );
  }
}
