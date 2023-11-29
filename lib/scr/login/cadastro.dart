import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class CadastroPage extends StatefulWidget {
  @override
  CadastroPageState createState() => CadastroPageState();
}

class CadastroPageState extends State<CadastroPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController =
      TextEditingController();
  String senhaError = '';

  bool aceitouTermos = false;
  bool senhaVisivel = false;

  bool senhasIguais() {
    return senhaController.text == confirmarSenhaController.text;
  }

  String nomeDoUsuario = '';

  Future<void> cadastrarUsuario(String nome, String email, String senha) async {
    if (senha.length < 6) {
      setState(() {
        senhaError = 'A senha deve ter pelo menos 6 caracteres.';
      });
      return;
    }

    // Limpar o erro se a senha for válida.
    setState(() {
      senhaError = '';
    });
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  Future<void> fazerCadastro(String nome, String email, String senha) async {
  try {
    // Dados para Firebase Auth
    final authData = {
      "email": email,
      "senha": senha,
    };

    // Dados para MongoDB
    final mongoData = {
      "nome": nome,
      "email": email,
    };

    UserCredential userCredential;

    try {
      // Primeiro, crie o usuário no Firebase Auth
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
    } catch (error) {
      print('Erro ao criar usuário no Firebase Auth: $error');
      // Lide com o erro, como mostrar uma mensagem de erro ao usuário
      return;
    }

    if (userCredential.user != null && userCredential.user!.email != null) {
      final email = userCredential.user!.email;

      // Se o usuário foi criado no Firebase Auth com sucesso, agora envie os dados para o MongoDB
      final response = await http.post(
        Uri.parse('http://localhost:3001/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(mongoData),
      );

      if (response.statusCode == 201) {
        print('Usuário cadastrado com sucesso no Firebase e no MongoDB');
        // Lide com a resposta do servidor MongoDB ou Firebase Auth, se necessário
      } else {
        print('Erro ao cadastrar usuário no MongoDB');
        // Lide com o erro, como mostrar uma mensagem de erro ao usuário
      }
    } else {
      print('Erro ao criar usuário no Firebase Auth');
      // Lide com o erro, como mostrar uma mensagem de erro ao usuário
    }
  } catch (error) {
    // Dados para Firebase Auth
    final authData = {
      "email": email,
      "senha": senha,
    };

    // Dados para MongoDB
    final mongoData = {
      "nome": nome,
      "email": email,
    };

    UserCredential userCredential;

    try {
      // Primeiro, crie o usuário no Firebase Auth
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
    } catch (error) {
      print('Erro ao criar usuário no Firebase Auth: $error');
      // Lide com o erro, como mostrar uma mensagem de erro ao usuário
      return;
    }

    if (userCredential.user != null && userCredential.user!.email != null) {
      final email = userCredential.user!.email;

      // Se o usuário foi criado no Firebase Auth com sucesso, agora envie os dados para o MongoDB
      final response = await http.post(
        Uri.parse('http:///10.2.130.76:3001/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(mongoData),
      );

      if (response.statusCode == 201) {
        print('Usuário cadastrado com sucesso no Firebase e no MongoDB');
        // Lide com a resposta do servidor MongoDB ou Firebase Auth, se necessário
      } else {
        print('Erro ao cadastrar usuário no MongoDB');
        // Lide com o erro, como mostrar uma mensagem de erro ao usuário
      }
    } else {
      print('Erro ao criar usuário no Firebase Auth');
      // Lide com o erro, como mostrar uma mensagem de erro ao usuário
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Faça seu Cadastro',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                FractionallySizedBox(
                  widthFactor: 0.6,
                  child: TextField(
                    controller: nomeController,
                    onChanged: (value) {
                      setState(() {
                        nomeDoUsuario = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FractionallySizedBox(
                  widthFactor: 0.6,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FractionallySizedBox(
                  widthFactor: 0.6,
                  child: TextField(
                    controller: senhaController,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            senhaVisivel = !senhaVisivel;
                          });
                        },
                        icon: Icon(senhaVisivel
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    obscureText: !senhaVisivel,
                  ),
                ),
                const SizedBox(height: 10),
                FractionallySizedBox(
                  widthFactor: 0.6,
                  child: TextField(
                    controller: confirmarSenhaController,
                    decoration: InputDecoration(
                      labelText: 'Confirmar Senha',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    enabled: aceitouTermos,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Termos de Uso e Política de Privacidade'),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const Text(
                                      '''  
                                    Termos de Uso - Car Hunters

                                    Bem-vindo ao Car Hunters!

                                    Ao acessar ou usar o Car Hunters, você concorda com estes Termos de Uso. Leia atentamente estes Termos antes de usar o aplicativo.

                                    Conta do Usuário:

                                    Você é responsável por manter a confidencialidade de sua conta e senha. Garantimos que sua senha será armazenada de forma criptografada para proteger suas informações.

                                    Dados do Usuário:

                                    Ao utilizar o Car Hunters, você concorda com a coleta e o armazenamento dos seus dados pessoais. Garantimos que seus dados serão armazenados de forma segura e utilizados apenas de acordo com nossa Política de Privacidade.

                                    Moeda Virtual:

                                    Haverá uma moeda virtual que tem como finalidade promover vouchers de desconto com os sites parceiros ou ainda desconto no próprio site. Por enquanto, esta moeda encontra-se inativa e é apenas uma simulação para ativá-la no futuro.

                                    Exclusão da Conta:

                                    Você pode solicitar a exclusão da sua conta a qualquer momento. Para fazer isso, basta acessar sua conta e clicar no botão "Excluir Conta". Após a exclusão da conta, seus dados serão removidos de nossos sistemas, conforme descrito em nossa Política de Privacidade.

                                    Uso Adequado:

                                    Você concorda em usar o Car Hunters de acordo com todas as leis, regulamentos e estes Termos. Você não deve utilizar o serviço de maneira inadequada, incluindo, mas não se limitando a, violar direitos de terceiros ou praticar atividades ilegais.

                                    Cadastro e Redirecionamento:

                                    Você será redirecionado ao site do anúncio somente após fazer o cadastro e este ser validado por nossa equipe. O cadastro é necessário para garantir uma experiência segura e confiável aos usuários.

                                    Alterações nos Termos:

                                    Reservamo-nos o direito de modificar estes Termos a qualquer momento. Notificaremos você sobre quaisquer alterações significativas. O uso continuado do Car Hunters após tais alterações constituirá sua aceitação dos Termos revisados.

                                    Encerramento do Serviço:

                                    Reservamo-nos o direito de encerrar ou suspender o Car Hunters a qualquer momento, sem aviso prévio, por qualquer motivo, incluindo, mas não se limitando a, violações destes Termos.

                                    Contato:

                                    Se você tiver alguma dúvida sobre estes Termos, entre em contato conosco em carhuntersfc@gmail.com.

                                    Ao usar o Car Hunters, você concorda e aceita estes Termos de Uso. Obrigado por usar o Car Hunters!
                                    

                                    Política de Privacidade - Car Hunters

                                    Última Atualização: 10/10/2023

                                    O Car Hunters está comprometido em proteger a privacidade dos usuários do nosso aplicativo. Esta Política de Privacidade descreve como coletamos, usamos e compartilhamos informações quando você utiliza o Car Hunters. Ao utilizar nosso aplicativo, você concorda com as práticas descritas nesta Política de Privacidade.

                                    Informações que Coletamos:

                                    Informações de Conta:
                                    Coletamos informações pessoais quando você cria uma conta, incluindo seu nome, endereço de e-mail e senha. Suas senhas são armazenadas de forma segura e criptografada.

                                    Informações do Anúncio:
                                    Quando você cria um anúncio de carro, podemos coletar informações sobre o veículo, como marca, modelo, ano, preço e descrição.

                                    Informações de Uso:
                                    Coletamos informações sobre como você usa o aplicativo, incluindo páginas visitadas, interações com anúncios e termos de pesquisa.

                                    Moeda Virtual:
                                    Haverá uma moeda virtual que tem como finalidade promover vouchers de desconto com os sites parceiros ou ainda desconto no próprio site. Por enquanto, esta moeda encontra-se inativa e é apenas uma simulação para ativá-la no futuro.

                                    Como Usamos Suas Informações:

                                    Personalização: Utilizamos suas informações para personalizar sua experiência no Car Hunters, mostrando anúncios e resultados de busca relevantes para você.

                                    Comunicação: Podemos usar seu endereço de e-mail para enviar notificações importantes sobre sua conta, anúncios ou alterações nos nossos serviços.

                                    Melhorias no Serviço: Usamos informações de uso para analisar padrões de tráfego e fazer melhorias no nosso aplicativo.

                                    Compartilhamento de Informações:

                                    Anunciantes e Parceiros: Podemos compartilhar informações anônimas com anunciantes e parceiros para fins de marketing e análise.

                                    Requisitos Legais: Em algumas circunstâncias, podemos ser obrigados a divulgar informações pessoais em resposta a solicitações legais das autoridades públicas.

                                    Seus Direitos:

                                    Você pode revisar e atualizar suas informações de conta a qualquer momento no aplicativo.

                                    Você tem o direito de solicitar a exclusão da sua conta e a remoção de seus dados do nosso sistema.

                                    Segurança das Informações:

                                    Implementamos medidas de segurança para proteger suas informações pessoais contra acesso não autorizado e uso indevido.

                                    Alterações nesta Política de Privacidade:

                                    Reservamo-nos o direito de fazer alterações nesta Política de Privacidade a qualquer momento. Notificaremos você sobre alterações significativas por meio do nosso aplicativo.

                                    Contato:

                                    Se você tiver alguma dúvida sobre esta Política de Privacidade, entre em contato conosco em carhuntersfc@gmail.com.

                                    Ao utilizar o Car Hunters, você concorda e aceita nossa Política de Privacidade. Obrigado por confiar em nós para suas necessidades de busca por carros!

                                      '''
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          aceitouTermos = !aceitouTermos;
                                          if (!aceitouTermos) {
                                            confirmarSenhaController.text = '';
                                          }
                                        });
                                      },
                                      child: Text(aceitouTermos
                                          ? 'Desmarcar Termos de Privacidade'
                                          : 'Aceitar Termos de Privacidade'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(aceitouTermos
                          ? 'Termos de Privacidade Aceitos'
                          : 'Toque para Ler Termos de Privacidade'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Lógica do botão de cadastro...
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF0E3B50),
                    onPrimary: Colors.white,
                  ),
                  child: const Text('Cadastrar'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
