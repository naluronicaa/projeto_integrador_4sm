import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pi4sm/scr/pagina_inicial.dart';
import 'package:pi4sm/scr/pagina_usuario.dart';
import 'package:pi4sm/scr/pagina_pesquisa.dart';

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
                _launchURL();
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Sair', style: TextStyle(fontSize: 20)),
              onTap: () {
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
