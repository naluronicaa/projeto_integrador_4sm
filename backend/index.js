require('dotenv').config();
const { MongoClient } = require('mongodb');
const express = require('express');
const cors = require('cors');
const app = express();
const jwt = require('jsonwebtoken');
const nodemailer = require('nodemailer');
const functions = require('firebase-functions');
const admin = require('firebase-admin');



const mongodbUri = process.env.MONGODB_URI;
const jwtSecret = process.env.JWT_SECRET;
const port = process.env.PORT;
const allowedOrigin = process.env.ALLOWED_ORIGIN || '*';
const serviceAccount = require('./chave-privada.json');

app.use(cors({
  origin: allowedOrigin,
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  credentials: true,
}));
app.use(express.json());

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://carhunters.firebaseio.com',
});

if (admin.apps.length > 0) {
  console.log('Conectado ao Firebase');
} else {
  console.log('Não conectado ao Firebase');
}

const client = new MongoClient(mongodbUri);

// Conexão ao MongoDB
async function connectToMongoDB() {
  try {
    await client.connect();
    console.log('Conectado ao MongoDB Atlas');


    // CADASTRO

    //Cadastro de usuarios (no firebase)
    async function createUserInFirebase(email, senha) {
      try {
        // Crie o usuário no Firebase Authentication
        const userRecord = await admin.auth().createUser({
          email: email,
          password: senha,
        });
    
        return userRecord;
      } catch (error) {
        throw error;
      }
    }

    // Cadastro de usuários(no mongo: nome e email, no firebase: email e senha)
    app.post('/users', async (req, res) => {
      const { nome, email, senha } = req.body;
    
      const db = client.db('erapraseropi');
      const collection = db.collection('usuarios');

      const user = { nome, email };
      const resultado = await collection.insertOne(user);
      console.log('Usuário cadastrado com sucesso:', resultado.insertedId);

       try {
    await createUserInFirebase(email, senha);
    console.log('Usuário criado com sucesso no Firebase');
    res.status(201).json({ message: 'Usuário cadastrado com sucesso' });
  } catch (error) {
    console.error('Erro ao criar usuário no Firebase:', error);
    // Lida com o erro
    res.status(500).json({ message: 'Erro ao criar usuário no Firebase' });
  }
});

   


// Função para criar token de autenticação
function criarTokenDeAutenticacao(usuario) {
  const payload = {
    id: usuario._id,
    senha: usuario.senha,
  };
  const token = jwt.sign(payload, jwtSecret, { expiresIn: '1h' });
  return token;
}

    // Login
app.post('/login', async (req, res) => {
  const { email, senha } = req.body;

  try {
    // Autenticar o usuário no Firebase Authentication
    const user = await admin.auth().getUserByEmail(email);

    // Verifica a senha
    if (user && user.email === email) {
      // Cria um token de autenticação, se necessário
      const token = criarTokenDeAutenticacao(user);
      res.status(200).json({ token });
    } else {
      res.status(401).json({ message: 'Credenciais inválidas' });
    }
  } catch (error) {
    console.error('Erro ao autenticar o usuário no Firebase:', error);
    res.status(500).json({ message: 'Erro ao autenticar o usuário' });
  }
});

    


    // Rota para atualizar o nome do usuário
    app.put('/atualizar_nome', async (req, res) => {
      const { email, novoNome } = req.body;

      try {
        const db = client.db('erapraseropi');
        const collection = db.collection('usuarios');

        const usuario = await collection.findOne({ email });

        if (usuario) {
          // Atualiza o nome do usuário no MongoDB
          await collection.updateOne({ email }, { $set: { nome: novoNome } });

          res.status(200).json({ message: 'Nome atualizado com sucesso' });
        } else {
          res.status(404).json({ message: 'Usuário não encontrado' });
        }
      } catch (error) {
        console.error('Erro ao atualizar o nome do usuário:', error);
        res.status(500).json({ message: 'Erro ao atualizar o nome do usuário' });
      }
    });






    // Função para excluir um usuário no Firebase Authentication e no MongoDB
    async function deleteFirebaseUser(email) {
      try {
        // Exclua o usuário do Firebase Authentication com base no email
        const userRecord = await admin.auth().getUserByEmail(email);
        await admin.auth().deleteUser(userRecord.uid);
    
        // Exclua o usuário correspondente no MongoDB usando o email
        await collection.deleteOne({ email });
    
        console.log('Usuário excluído do Firebase Authentication e MongoDB com email:', email);
      } catch (error) {
        console.error('Erro ao excluir usuário do Firebase Authentication e MongoDB:', error);
      }
    }

    // Rota para deletar o usuário
    app.delete('/deletar_usuario', async (req, res) => {
      const { email } = req.body;

      try {
        // Exclua o usuário do Firebase Authentication com base no email
        const userRecord = await admin.auth().getUserByEmail(email);
        await admin.auth().deleteUser(userRecord.uid);

        // Exclua o usuário correspondente no MongoDB usando o email
        await collection.deleteOne({ email });

        res.status(200).json({ message: 'Usuário deletado com sucesso' });
      } catch (error) {
        console.error('Erro ao excluir o usuário:', error);
        res.status(500).json({ message: 'Erro ao excluir o usuário' });
      }
    });

    
    // Rota para atualizar o e-mail do usuário
    app.put('/atualizar_email', async (req, res) => {
      const { emailAtual, novoEmail } = req.body;

      try {
        const db = client.db('erapraseropi');
        const collection = db.collection('usuarios');

        const usuario = await collection.findOne({ email: emailAtual });

        if (usuario) {
          // Atualiza o e-mail do usuário no MongoDB
          await collection.updateOne({ email: emailAtual }, { $set: { email: novoEmail } });

          // Atualiza o e-mail do usuário no Firebase Authentication
          const userRecord = await admin.auth().getUserByEmail(emailAtual);
          await admin.auth().updateUser(userRecord.uid, { email: novoEmail });

          res.status(200).json({ message: 'E-mail atualizado com sucesso' });
        } else {
          res.status(404).json({ message: 'Usuário não encontrado' });
        }
      } catch (error) {
        console.error('Erro ao atualizar o e-mail do usuário:', error);
        res.status(500).json({ message: 'Erro ao atualizar o e-mail do usuário' });
      }
    });

    

    //Função que acompanha o mongo
    async function watchMongoDB() {
      try {
        await connectToMongoDB();
    
        const database = client.db('erapraseropi');
        collection = database.collection('usuarios');
    
        const changeStream = collection.watch();
    
        changeStream.on('change', async (change) => {
          console.log('Alteração no MongoDB:', change);
    
          if (change.operationType === 'insert') {
            const newUser = change.fullDocument;
    
            // Verifique se o documento no MongoDB possui o campo 'email'
            if (newUser.email) {
              // Encontre o usuário correspondente no Firebase Authentication pelo email
              admin.auth().getUserByEmail(newUser.email)
                .then((userRecord) => {
                  // Atualize os detalhes do usuário no MongoDB, se necessário
                  const updateFields = {};
    
                  // Verifique as mudanças no documento do MongoDB e atualize o usuário correspondente no Firebase Authentication
                  if (newUser.email !== userRecord.email) {
                    updateFields.email = newUser.email;
                  }
    
                  // Atualize o usuário, se houver mudanças
                  if (Object.keys(updateFields).length > 0) {
                    return admin.auth().updateUser(userRecord.uid, updateFields);
                  }
                })
                .then(() => {
                  console.log('Usuário atualizado no Firebase Authentication com email:', newUser.email);
                })
                .catch((error) => {
                  console.error('Erro ao atualizar usuário no Firebase Authentication:', error);
                });
            } else {
              // O novo documento não possui um email, criando um novo usuário no Firebase
              createUserInFirebase(newUser.email, newUser.senha)
                .then((userRecord) => {
                  // Atualize o documento no MongoDB com o UID ou email (como preferir)
                  collection.updateOne(
                    { email: newUser.email },
                    { $set: { uid: userRecord.uid } }
                  )
                  .then(() => {
                    console.log('Novo usuário criado no Firebase Authentication e UID registrado no MongoDB:', userRecord);
                  })
                  .catch((error) => {
                    console.error('Erro ao registrar UID no MongoDB:', error);
                  });
                })
                .catch((error) => {
                  console.error('Erro ao criar usuário no Firebase Authentication:', error);
                });
            }
          } else if (change.operationType === 'delete') {
            const deletedUser = change.fullDocument;
    
            if (deletedUser && deletedUser.email) {
              // Exclua o usuário do Firebase Authentication com base no email
              admin.auth().getUserByEmail(deletedUser.email)
                .then((userRecord) => {
                  deleteFirebaseUser(userRecord.uid);
                })
                .catch((error) => {
                  console.error('Erro ao excluir usuário no Firebase Authentication:', error);
                });
            }
          }
        });
      } catch (error) {
        console.error('Erro ao observar o MongoDB:', error);
      }
    }
    
    
   // Rota para obter o nome do usuário com base no email
  app.get('/obter_nome', async (req, res) => {
    const { email } = req.query;

    try {
      const db = client.db('erapraseropi');
      const collection = db.collection('usuarios');

      const usuario = await collection.findOne({ email });

      if (usuario) {
        const { nome } = usuario;
        res.status(200).json({ nome });
      } else {
        res.status(404).json({ message: 'Usuário não encontrado' });
      }
    } catch (error) {
      console.error('Erro ao obter o nome do usuário:', error);
      res.status(500).json({ message: 'Erro ao obter o nome do usuário' });
    }
  });
  
    // Rota para obter todos os usuários
    app.get('/usuarios', async (req, res) => {
      try {
        const db = client.db('erapraseropi');
        const collection = db.collection('usuarios');
    
        const usuarios = await collection.find().toArray();
    
        if (usuarios.length > 0) {
          // Mapeia os usuários para retornar apenas os nomes e emails
          const usuariosSimplificados = usuarios.map(usuario => ({
            nome: usuario.nome,
            email: usuario.email
          }));
          res.status(200).json(usuariosSimplificados);
        } else {
          res.status(404).json({ message: 'Não existem cadastros de usuários' });
        }
      } catch (error) {
        console.error('Erro ao obter usuários:', error);
        res.status(500).json({ message: 'Erro ao obter usuários' });
      }
    });
    

    
    // Rota de pesquisa no Mercado Livre
    app.get('/pesquisa', async (req, res) => {
      try {
        // Lógica para realizar a pesquisa no Mercado Livre
        // ...
        res.status(200).json({ message: 'Resultados da pesquisa' });
      } catch (err) {
        console.error('Erro ao realizar pesquisa no Mercado Livre:', err);
        res.status(500).json({ message: 'Erro na pesquisa' });
      }
    });

    app.listen(port, () => {
      console.log(`Servidor Node.js rodando na porta ${port}`);
    });
  } catch (err) {
    console.error('Erro ao conectar ao MongoDB Atlas:', err);
  }
}


// Rota para adicionar um carro aos favoritos do usuário
app.post('/favoritos/adicionar', async (req, res) => {
  const { email, carro } = req.body;

  try {
    const db = client.db('erapraseropi');
    const collection = db.collection('usuarios');

    // Atualiza a lista de favoritos do usuário com o novo carro
    const result = await collection.updateOne(
      { email },
      { $addToSet: { favoritos: carro } } // Usando $addToSet para evitar duplicatas
    );

    if (result.modifiedCount > 0) {
      res.status(200).json({ message: 'Carro adicionado aos favoritos do usuário' });
    } else {
      res.status(404).json({ message: 'Usuário não encontrado' });
    }
  } catch (error) {
    console.error('Erro ao adicionar carro aos favoritos:', error);
    res.status(500).json({ message: 'Erro ao adicionar carro aos favoritos' });
  }
});


// Rota para remover um carro dos favoritos do usuário
app.delete('/favoritos/remover', async (req, res) => {
  const { email, carId } = req.body;

  try {
    const db = client.db('erapraseropi');
    const collection = db.collection('usuarios');

    // Remove o carro da lista de favoritos do usuário
    const result = await collection.updateOne(
      { email },
      { $pull: { favoritos: carId } } // Remove o carro da lista de favoritos
    );

    if (result.modifiedCount > 0) {
      res.status(200).json({ message: 'Carro removido dos favoritos do usuário' });
    } else {
      res.status(404).json({ message: 'Usuário não encontrado ou o carro não estava nos favoritos' });
    }
  } catch (error) {
    console.error('Erro ao remover carro dos favoritos:', error);
    res.status(500).json({ message: 'Erro ao remover carro dos favoritos' });
  }
});


// Verificar se um carro está nos favoritos de um usuário
app.get('/favoritos/:email/:carId', async (req, res) => {
  const { email, carId } = req.params;

  try {
    const db = client.db('erapraseropi');
    const collection = db.collection('usuarios');

    // Encontra o usuário com o email fornecido
    const usuario = await collection.findOne({ email });

    if (!usuario || !usuario.favoritos || usuario.favoritos.length === 0) {
      res.status(200).json({ isFavorito: false }); // Se o usuário não existe ou não tem favoritos
    } else {
      // Verifica se o carro está nos favoritos do usuário
      const isFavorito = usuario.favoritos.includes(carId);

      res.status(200).json({ isFavorito });
    }
  } catch (error) {
    console.error('Erro ao verificar se o carro está nos favoritos:', error);
    res.status(500).json({ message: 'Erro ao verificar se o carro está nos favoritos' });
  }
});



//pegar os favoritos
app.get('/favoritos/:email', async (req, res) => {
  try {
    const { email } = req.params;

    // Buscar os carros favoritos do usuário pelo email
    const favoritos = await Favoritos.find({ email });

    res.status(200).json({ favoritos });
  } catch (error) {
    console.error('Erro ao buscar os carros favoritos:', error);
    res.status(500).json({ message: 'Erro ao buscar os carros favoritos' });
  }
});


connectToMongoDB();
