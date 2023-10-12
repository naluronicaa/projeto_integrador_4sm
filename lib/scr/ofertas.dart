import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CarroWidget extends StatelessWidget {
  final String nome;
  final String preco;
  final String fipe;
  bool isSelected = false;

  CarroWidget({required this.nome, required this.preco, required this.fipe});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      final bool isMobile = constraints.maxWidth < 600;
    return Container(
      padding: EdgeInsets.all(2.0),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            child: Image.asset(
              'assets/car_default.png',
              width: 50,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //nome = Modelo + Marca
              const SizedBox(height: 4),
              Text(nome, style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 30, 30, 30))),
              const SizedBox(height: 2),
              Text(preco, style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 30, 30, 30))),
              const SizedBox(height: 2),
              Text('Tabela FIPE: $fipe', style: const TextStyle(fontSize: 10, color: Color.fromARGB(130, 30, 30, 30))),
              const SizedBox(height: 2),
              Text('cor: xxxx, carroderia:xxxx,\ncondição:xxxx,ano:xxxx, km', style: TextStyle(fontSize: 8, color: Color.fromARGB(130, 30, 30, 30))),
            ],
          ),

          Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text('<<logo empresa>>', style: TextStyle(fontSize: 10),),
                  IconButton(
                    icon: isSelected ? Icon(Icons.star,  color: const Color.fromARGB(255, 223, 173, 44)) : Icon(Icons.star_border),
                    onPressed: () {
                      // Quando a estrela é clicada, altera o estado
                      isSelected = !isSelected;
                    },
                  ),
                ],
              ),

              Text('local  xxxx', style: TextStyle(fontSize: 10, color: Color.fromARGB(130, 30, 30, 30))),

              ElevatedButton(
                onPressed: () {
                  // colocar o link
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
                child: const Text('Ver Oferta', style: TextStyle(color: Colors.white)),
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
            child: Image.asset(
              'assets/car_default.png',
              width: 90,
              height: 80,
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
              Text(nome, style: const TextStyle(fontSize: 17, color: Color.fromARGB(255, 30, 30, 30))),
              const SizedBox(height: 2),
              Text(preco, style: const TextStyle(fontSize: 17, color: Color.fromARGB(255, 30, 30, 30))),
              const SizedBox(height: 2),
              Text('Tabela FIPE: $fipe', style: const TextStyle(fontSize: 15, color: Color.fromARGB(130, 30, 30, 30)))
            ],
          ),

          //segunda parte (ano, quilometro, local da venda)
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 4),
              Text('ano : XXXX', style: const TextStyle(fontSize: 15, color: Color.fromARGB(130, 30, 30, 30))),
              const SizedBox(height: 2),
              Text('KM : XXXXX', style: const TextStyle(fontSize: 15, color: Color.fromARGB(130, 30, 30, 30))),
              const SizedBox(height: 2),
              Text('local xxxxxxxx', style: const TextStyle(fontSize: 15, color: Color.fromARGB(130, 30, 30, 30)))
            ],
          ),

          //terceira parte (cor, carroceria, condição do carro)
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 4),
              Text('cor : XXXX', style: const TextStyle(fontSize: 15, color: Color.fromARGB(130, 30, 30, 30))),
              const SizedBox(height: 2),
              Text('carroceria : XXXXX', style: const TextStyle(fontSize: 15, color: Color.fromARGB(130, 30, 30, 30))),
              const SizedBox(height: 2),
              Text('condição: xxxx', style: const TextStyle(fontSize: 15, color: Color.fromARGB(130, 30, 30, 30)))
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
                  Text('<<logo empresa>>'),
                  IconButton(
                    icon: isSelected ? Icon(Icons.star,  color: const Color.fromARGB(255, 223, 173, 44)) : Icon(Icons.star_border),
                    onPressed: () {
                      // Quando a estrela é clicada, altera o estado
                      isSelected = !isSelected;
                    },
                  ),
                ],
              ),

              ElevatedButton(
                onPressed: () {
                  // colocar o link
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 15, 59, 80)), 
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: const Text('Ver Oferta', style: TextStyle(color: Colors.white)),
              )
            ],
            
          ),
          const SizedBox(width: 5)                
        ],
      )
    );
  });
  }
}
