import 'package:flutter/material.dart';
import 'package:pi4sm/scr/pagina_login.dart';
import 'package:pi4sm/widgets/app_large_text.dart';
import 'package:pi4sm/widgets/app_text.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {

  final ScrollController _controllerS = ScrollController();

  List imagens = [
    "pg1.png",
    "pg2.png",
    "pg3.png",
  ];

  List textosP = [
    "Bem",
    "Sobre",
    "Faça"
  ];

  List textosS = [
    "Vindo(a)!",
    "Nós...",
    "Login"
  ];

  List informacoes = [
    "Agora com o Car Hunters ficou bem mais fácil de você encontrar o seu carro ideal.",
    "Nosso objetivo é garantir que você consiga salvar dinheiro e tempo! Principalmente agora com a nossa moeda!",
    "Entre com sua conta agora e encontre seu carro."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebSmoothScroll(
        controller: _controllerS, 
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: imagens.length,
          itemBuilder: (_, index){
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/"+imagens[index]
                    ),
                    fit: BoxFit.cover
                  )
              ),
              child: Container(
                margin: const EdgeInsets.only(top:40, left: 30, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeTxt(size: 35, text: textosP[index], color: Colors.black),
                        AppTxt(size: 35, text: textosS[index], color: Colors.black54),
                        Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 40),
                          width: 300,
                          child: AppTxt(size: 18, text: informacoes[index], color: const Color.fromARGB(255, 15, 59, 80)),
                        ),

                        FloatingActionButton.extended(
                          label: AppTxt(size: 15, text: "Cadastre-se", color: Colors.white),
                          backgroundColor:const Color.fromARGB(255, 15, 59, 80),
                          icon: const Icon(
                            Icons.login,
                            color: Colors.white,
                            size: 24
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const PaginaLogin()));
                            }
                        )
                      ],
                    ),
                    Column(
                      children : List.generate(imagens.length, (indexDots) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 2),
                          width: 8,
                          height: index == indexDots?25:8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: index == indexDots?const Color.fromARGB(255, 15, 59, 80):const Color.fromARGB(100, 15, 59, 80)
                          )
                        );
                      }),
                    )
                  ],
                )
              ),
            );
        }
        ),
        )
      
    );
  }
}