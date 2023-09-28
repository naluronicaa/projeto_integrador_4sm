import 'package:flutter/material.dart';
import 'package:pi4sm/scr/pagina_usuario.dart';

class NavBar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Drawer(
      child : ListView(
        children: [
          ListTile(
            leading: Icon(Icons.menu),
            title: Text('Menu', style: TextStyle(fontSize: 20)),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Minha Conta', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => const PaginaUsuario()));
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart_checkout),
            title: Text('Ver Ofertas', style: TextStyle(fontSize: 20)),
            onTap: () =>  null,
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Meus Favoritos', style: TextStyle(fontSize: 20)),
            onTap: () =>  null,
          ),
          ListTile(
            leading: Icon(Icons.support_agent),
            title: Text('Suporte', style: TextStyle(fontSize: 20)),
            onTap: () =>  null,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair', style: TextStyle(fontSize: 20)),
            onTap: () =>  null,
          ),
        ],
      )
    );
  }
}