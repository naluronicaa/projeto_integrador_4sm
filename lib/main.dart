import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pi4sm/scr/pagina_inicial.dart';
import 'package:pi4sm/scr/login/mudarSenha/esqueci_senha.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCWLZYgUkW_50UZnGoKR9lBdxbN8DJT0qs",
      projectId: "carhunters-2b5e3",
      storageBucket: "carhunters-2b5e3.appspot.com",
      messagingSenderId: "948179322175",
      appId: "1:948179322175:web:c13d2f3b99267b3606bf8a",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Hunters',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/', // Rota inicial do seu aplicativo
      routes: {
        '/': (context) => const PaginaInicial(), // Rota inicial
        '/esqueci-senha': (context) => EsqueciSenhaPage(), // Rota para a página de redefinição de senha
      },
    );
  }
}
