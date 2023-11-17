import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pi4sm/scr/pagina_inicial.dart';
import 'package:pi4sm/scr/pagina_usuario.dart';
import 'package:pi4sm/scr/pagina_pesquisa.dart';
import 'utils.dart';
import 'dart:math' as math;

  class NavBar extends StatelessWidget{
    @override
    Widget build(BuildContext context){
      return Drawer(
        child : ListView(
          children: [
            const ListTile(
              leading: Icon(Icons.menu),
              title: Text('Menu', style: TextStyle(fontSize: 20)),
            ),
            const Divider(),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const  Text('Minha Conta', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PaginaUsuario()));
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.shopping_cart_checkout),
              title: const Text('Ver Ofertas', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PaginaPrincipal()));
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Meus Favoritos', style: TextStyle(fontSize: 20)),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PaginaUsuario()));
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.support_agent),
              title: const Text('Suporte', style: TextStyle(fontSize: 20)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Mensagem do Suporte!'),
                      content: const Text('Olá! caso esteja em um dispositivo mobile,\nentre em contato conosco pelo email:\n carhuntersofc@gmail.com'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 216, 7, 7))
                          ),
                          child: const Text('Fechar', style: TextStyle(color: Colors.white),),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Fecha o AlertDialog
                            _launchURL(); // Chama a função _launchURL
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255,15, 59, 80))
                          ),
                          child: const Text('Estou em outro dispositivo!', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              leading:Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: Icon(Icons.exit_to_app),
              ),
              title: const Text('Sair', style: TextStyle(fontSize: 20)),
              onTap: () async {
                await setPopupExibido(false); // Define o valor como false
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PaginaInicial()));
              },
            ),
          ],
        )
      );
    }
  }

void _launchURL() async {
  const texto = 'Relate seu Problema aqui!';
  final url = Uri(
    scheme: 'mailto',
    path: 'carhuntersofc@gmail.com',
    query: 'subject=${Uri.encodeComponent(texto)}'
  );
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Não foi possível abrir o link $url';
  }
}
