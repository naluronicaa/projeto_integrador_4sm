import 'package:flutter/material.dart';

class ProdutoWidget extends StatelessWidget {
  final String nome;
  final String preco;

  ProdutoWidget({required this.nome, required this.preco});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nome,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Text(
            'Preço: $preco',
            style: TextStyle(fontSize: 16.0),
          ),
          // Adicione outras informações conforme necessário
        ],
      ),
    );
  }
}
