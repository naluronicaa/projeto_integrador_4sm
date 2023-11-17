/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

const functions = require('firebase-functions');
const admin = require('firebase-admin');
const MongoClient = require('mongodb').MongoClient;

admin.initializeApp();

// Configure o cliente MongoDB aqui
const { MONGO_URL } = functions.config().mongodb;
const client = new MongoClient(MONGO_URL, { useNewUrlParser: true });

exports.syncPasswordToMongoDB = functions.auth.user().onUpdate(async (user) => {
  const uid = user.uid;
  const newPassword = user.password || ''; // Nova senha definida no Firebase Authentication

  try {
    await client.connect(); // Conectar ao MongoDB aqui

    const db = client.db('CarHunters');
    collection = db.collection('usuarios');

    // Encontre o usuário correspondente no MongoDB usando o UID
    const userInMongoDB = await collection.findOne({ uid: uid });

    if (userInMongoDB) {
      // Atualize a senha no MongoDB
      await collection.updateOne({ uid: uid }, { $set: { senha: newPassword } });
      console.log('Senha do usuário atualizada no MongoDB');
    } else {
      console.error('Usuário não encontrado no MongoDB');
    }
  } catch (error) {
    console.error('Erro ao sincronizar senha no MongoDB:', error);
  }
});
