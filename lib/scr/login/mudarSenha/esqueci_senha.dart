import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;




class EsqueciSenhaPage extends StatefulWidget {
  @override
  _EsqueciSenhaPageState createState() => _EsqueciSenhaPageState();
}

class _EsqueciSenhaPageState extends State<EsqueciSenhaPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _resetPassword() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(
            email: _emailController.text,
          );
          // Exibir uma mensagem de sucesso e redirecionar o usuário para a tela de login, por exemplo.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Um link de recuperação de senha foi enviado para o seu email."),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Ocorreu um erro ao enviar o email de recuperação de senha."),
            ),
          );
        }
      }
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Esqueci a Senha"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Por favor, insira o email associado à sua conta para redefinir a senha.",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, insira seu email.";
                    }

                    // Adicione a condição para verificar o email
                    if (value == "carhuntersofc@gmail.com") {
                      // Exiba a mensagem indicando que o email não pode ter a senha alterada
                      return "Esse email não pode ter sua senha alterada.";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _resetPassword,
                  child: Text("Redefinir Senha"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}