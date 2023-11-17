const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { MongoClient } = require('mongodb');
require('dotenv').config();



const mongodbUri = process.env.MONGODB_URI;
const serviceAccount = require('./chave-privada.json');

admin.initializeApp({
  credential: admin.credential.applicationDefault(),
});

const client = new MongoClient(mongodbUri);
let collection; // Defina a coleção como uma variável global





// Função para criar um novo usuário no Firebase Authentication e no MongoDB
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



// Função para excluir um usuário no Firebase Authentication e no MongoDB
async function deleteFirebaseUserAndMongoDB(userUid) {
  try {
    // Exclua o usuário do Firebase Authentication
    await admin.auth().deleteUser(userUid);

    // Exclua o usuário correspondente no MongoDB usando o UID
    await collection.deleteOne({ uid: userUid });

    console.log('Usuário excluído do Firebase Authentication e MongoDB com UID:', userUid);
  } catch (error) {
    console.error('Erro ao excluir usuário do Firebase Authentication e MongoDB:', error);
  }
}






async function watchMongoDB() {
  try {
    await client.connect(); // Conectar ao MongoDB aqui
    console.log('Conexão com o MongoDB estabelecida com sucesso');
    
    const database = client.db('erapraseropi');
    collection = database.collection('usuarios'); // Defina a coleção aqui
    
    const changeStream = collection.watch();

    changeStream.on('change', async (change) => {
      console.log('Alteração no MongoDB:', change); // Adicione este log para registrar as mudanças
      
      if (change.operationType === 'insert') {
        const newUser = change.fullDocument;
        
        // Verifique se o documento no MongoDB possui o campo 'uid'
        if (newUser.uid) {
          // Encontre o usuário correspondente no Firebase Authentication pelo UID
          admin.auth().getUser(newUser.uid)
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
            console.log('Usuário atualizado no Firebase Authentication com UID:', newUser.uid);
          })
          .catch((error) => {
            console.error('Erro ao atualizar usuário no Firebase Authentication:', error);
          });
        }




        else {
          // O novo documento não possui um UID, criando um novo usuário no Firebase
          createUserInFirebaseAndMongo(newUser.email, newUser.senha) // Chama a função para criar usuário no Firebase e MongoDB
            .then((userRecord) => {
              // Atualize o documento no MongoDB com o UID
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
      
        if (deletedUser && deletedUser.uid) {
          // Exclua o usuário do Firebase Authentication com base no UID
          deleteFirebaseUserAndMongoDB(deletedUser.uid); // Chama a função para excluir o usuário no Firebase e MongoDB
        }
      
        
      }
    });
  } catch (error) {
    console.error('Erro ao observar o MongoDB:', error);
  }
}






watchMongoDB();



//Ideia  senha separada






