const express = require('express');
const { MongoClient } = require('mongodb');

const mongodbUri = 'mongodb+srv://analuisaa:socorrodeus@teste.7tjmkgx.mongodb.net/';
const port = 3001;

const client = new MongoClient(mongodbUri);
const app = express();

app.use(express.json());

const cors = require('cors');
app.use(cors());

let carrosCollection; // Variável global para a coleção de carros

async function connectToMongoDB() {
  try {
    await client.connect();
    console.log(`Conectado ao MongoDB`);

    const db = client.db("erapraseropi");
    carrosCollection = db.collection("carros");
  } catch (err) {
    console.error("Erro ao conectar ao MongoDB: ", err);
  }
}

connectToMongoDB().then(() => {
  app.get('/carrosFiltrados', async (req, res) => {
    try {
      const { termo, filtros, filtrosIntervalos, relevancia } = req.query;
      let filtro = {};

      // Filtro de busca (alguma melhoria que deixa que o usuário possa digitar esses valores em qualquer ordem)
      if (termo) {
        const regexTermo = new RegExp(termo, 'i');
        filtro = {
          $or: [
            { marca: regexTermo },
            { modelo: regexTermo },
            { ano: regexTermo },
            { cor: regexTermo },
            { carroceria: regexTermo }
          ]
        };
      }

      //filtros do tipo igual (adicionar a parte dos "outros")
      if (filtros) {
        Object.keys(JSON.parse(filtros)).forEach(chave => {
          filtro[chave] = JSON.parse(filtros)[chave];
        });
      }

      //filtros de intervalo
      if (filtrosIntervalos) {
        const intervalos = JSON.parse(filtrosIntervalos);
      
        Object.keys(intervalos).forEach(chave => {
          const filtroIntervalo = intervalos[chave];
          const [min, max] = [filtroIntervalo.min, filtroIntervalo.max];
          
          filtro[chave] = {
            $gte: min,
            $lte: max
          };
        });
      }      

      // Ordena
      if (relevancia) {
        if (relevancia === "Menor Preço") {
          const carrosFiltrados = await carrosCollection.find(filtro).sort({ preco: 1 }).toArray();
          res.json(carrosFiltrados);
        } else if (relevancia === "Maior Preço") {
          const carrosFiltrados = await carrosCollection.find(filtro).sort({ preco: -1 }).toArray();
          console.log(carrosFiltrados);
          res.json(carrosFiltrados);
        } else if (relevancia === "Menor KM") {
          const carrosFiltrados = await carrosCollection.find(filtro).sort({ km: 1 }).toArray();
          res.json(carrosFiltrados);
        } else if (relevancia === "Maior KM") {
          const carrosFiltrados = await carrosCollection.find(filtro).sort({ km: -1 }).toArray();
          res.json(carrosFiltrados);
        } else {
          const carrosFiltrados = await carrosCollection.find(filtro).toArray();
          res.json(carrosFiltrados);
        }
      } else {
        const carrosFiltrados = await carrosCollection.find(filtro).toArray();
      
        res.json(carrosFiltrados);
      }

    } catch (err) {
      console.error("Erro ao obter carros filtrados: ", err);
      res.status(500).send("Erro ao obter carros filtrados");
    }
  });

  // Iniciar o servidor
  app.listen(port, () => {
    console.log(`Servidor rodando na porta ${port}`);
  });
});

