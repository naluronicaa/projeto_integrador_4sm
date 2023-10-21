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

async function filtrarCarrosPorRelevancia(filtro, relevanciaEscolhida) {
  let tipoRelevancia;

  if (relevanciaEscolhida === "Maior Preço" || relevanciaEscolhida === "Menor Preço") {
    tipoRelevancia = 'preco';
  } else if (relevanciaEscolhida === "Maior KM" || relevanciaEscolhida === "Menor KM") {
    tipoRelevancia = 'km';
  }

  const carrosFiltrados = await carrosCollection.find(filtro).toArray();

  carrosFiltrados.sort((a, b) => {
    if (tipoRelevancia === 'preco') {
      return a.preco - b.preco;
    } else if (tipoRelevancia === 'km') {
      return a.km - b.km;
    }
    return 0;
  });

  return carrosFiltrados;
}

async function connectToMongoDB() {
  try {
    await client.connect();
    console.log(`Conectado ao MongoDB`);

    const db = client.db("erapraseropi");
    carrosCollection = db.collection("carros"); // Atribui a coleção à variável global
  } catch (err) {
    console.error("Erro ao conectar ao MongoDB: ", err);
  }
}

connectToMongoDB().then(() => {
  app.get('/carrosFiltrados', async (req, res) => {
    try {
      const { termo, filtros, filtrosIntervalos, relevancia } = req.query;

      let filtro = {};

      // Filtro de busca
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

      //filtros do tipo igual
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
        const { relevancia: relevanciaEscolhida } = relevancia;

        if (relevanciaEscolhida === "Menor Preço") {
          const carrosFiltrados = await carrosCollection.find(filtro).sort({ preco: 1 }).toArray();
          res.json(carrosFiltrados);
        } else if (relevanciaEscolhida === "Maior Preço") {
          const carrosFiltrados = await carrosCollection.find(filtro).sort({ preco: -1 }).toArray();
          res.json(carrosFiltrados);
        } else if (relevanciaEscolhida === "Menor KM") {
          const carrosFiltrados = await carrosCollection.find(filtro).sort({ km: 1 }).toArray();
          res.json(carrosFiltrados);
        } else if (relevanciaEscolhida === "Maior KM") {
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

