const express = require ('express')
const app = express()
app.use(express.json())

let users = [
   {
    'nome' : 'administrador',
    'email' : 'carhuntersofc@gmail.com',
    'senha' : 'pi4SM2023'
   }
   ]
let carros = [
    //simulação - webmotors:
    {
        'marca': 'Fiat',
        'modelo': 'strada',
        'cor': 'prata',
        'ano': '2022',
        'preco': 'R$77.960,00',
        'km': '56.953',
        'localização': 'Presidente prudente - SP',
        'carroceria' : 'picape',
        'condição' : 'Seminovo',
        'tabela FIPE' : 'R$80.635,00'
    },
    {
        'marca': 'JEEP',
        'modelo': 'compass',
        'cor': 'prata',
        'ano': '2022',
        'preco': 'R$146.140,00',
        'km': '37.985',
        'localização': 'Ananindeua - PA',
        'carroceria' : 'utilitário esportivo',
        'condição' : 'Seminovo',
        'tabela FIPE' : 'R$152.674,00'
    },
    {
        'marca': 'VolksWagen',
        'modelo': 'voyage',
        'cor': 'cinza',
        'ano': '2021',
        'preco': 'R$66.320,00',
        'km': '23.958',
        'localização': 'Ananindeua - PA',
        'carroceria' : 'sedã',
        'condição' : 'Seminovo',
        'tabela FIPE' : 'R$62.804,00'

    },
    {
        'marca': 'Toyota',
        'modelo': 'Corolla',
        'cor': 'preto',
        'ano': '2022',
        'preco': 'R$133.570,00',
        'km': '50.865',
        'localização': 'Ananindeua - PA',
        'carroceria' : 'sedã',
        'condição' : 'Seminovo',
        'tabela FIPE' : 'R$134.953,00'
    },
    {
        'marca': 'Honda',
        'modelo': 'City',
        'cor': 'vermelho',
        'ano': '2022',
        'preco': 'R$117.800,00',
        'km': '50.865',
        'localização': 'São Paulo - SP',
        'carroceria' : 'hatchback',
        'condição' : 'usado',
        'tabela FIPE' : 'R$114.301,00'
    },
    {
        'marca': 'Mitsubishi',
        'modelo': 'Pajero TR4',
        'cor': 'preto',
        'ano': '2013',
        'preco': 'R$57.990,00',
        'km': '104.199',
        'localização': 'Americana - SP',
        'carroceria' : 'utilitário esportivo',
        'condição' : 'Novo',
        'tabela FIPE' : 'R$56.715,00'
    },
    {
        'marca': 'Renault',
        'modelo': 'Master',
        'cor': 'branco',
        'ano': '2019',
        'preco': 'R$149.900,00',
        'km': '53.805',
        'localização': 'Colombo - PR',
        'carroceria' : 'van/utilitário',
        'condição' : 'Seminovo',
        'tabela FIPE' : 'R$155.849,00'
    },
    {
        'marca': 'Ford',
        'modelo': 'EcoSport',
        'cor': 'branco',
        'ano': '2014',
        'preco': 'R$48.099,00',
        'km': '88.126',
        'localização': 'Rio de Janeiro - RJ',
        'carroceria' : 'utilitário/esportivo',
        'condição' : 'Seminovo',
        'tabela FIPE' : 'R$52.082,00'
    },
    {
        'marca': 'Hyundai',
        'modelo': 'HB20',
        'cor': 'vermelho',
        'ano': '2014',
        'preco': 'R$44.399,00',
        'km': '85.032',
        'localização': 'Rio de Janeiro - RJ',
        'carroceria' : 'hatchback',
        'condição' : 'Seminovo',
        'tabela FIPE' : 'R$46.818,00'
    },
    {
        'marca': 'Chevrolet',
        'modelo': 'Onix',
        'cor': 'azul',
        'ano': '2023',
        'preco': 'R$78.900,00',
        'km': '87.349',
        'localização': 'Uberlândia - MG',
        'carroceria' : 'sedã',
        'condição' : 'usado',
        'tabela FIPE' : 'R$90.403,00'
    },

    //simulação - olx:
    {
        'marca': 'VolksWagen',
        'modelo': 'Saveiro Cross',
        'cor': 'prata',
        'ano': '2022',
        'preco': 'R$96.900,00',
        'km': '16.700',
        'localização': 'Rolândia - PR',
        'carroceria' : 'picape',
        'condição' : 'Seminovo',
        'tabela FIPE' : 'R$94.421,00'
    },
    {
        'marca': 'Renault',
        'modelo': 'Logan',
        'cor': 'branco',
        'ano': '2023',
        'preco': 'R$71.890,00',
        'km': '19.541',
        'localização': 'Florianópolis - SC',
        'carroceria' : 'sedã',
        'condição' : 'Seminovo',
        'tabela FIPE' : 'R$72.466,00'
    },
    {
        'marca': 'Hyundai',
        'modelo': 'HB20 Comfort',
        'cor': 'preto',
        'ano': '2015',
        'preco': 'R$44.900,00',
        'km': '88.000',
        'localização': 'Salvador - BA',
        'carroceria' : 'hatch',
        'condição' : 'usado',
        'tabela FIPE' : 'R$44.276,00'
    },
    {
        'marca': 'Fiat',
        'modelo': 'Cronos',
        'cor': 'branco',
        'ano': '2022',
        'preco': 'R$74.490,00',
        'km': '57.505',
        'localização': 'São Paulo - SP',
        'carroceria' : 'sedã',
        'condição' : 'Seminovo',
        'tabela FIPE' : 'R$72.165,00'
    },
    {
        'marca': 'Honda',
        'modelo': 'Civic',
        'cor': 'prata',
        'ano': '1998',
        'preco': 'R$23.890,00',
        'km': '230.000',
        'localização': 'Santo André - SP ',
        'carroceria' : 'sedã',
        'condição' : 'usado',
        'tabela FIPE' : 'R$16.801,00'
    },
    {
        'marca': 'Chevrolet',
        'modelo': 'Blazer',
        'cor': 'branco',
        'ano': '2022',
        'preco': 'R$186.990,00',
        'km': '55.625',
        'localização': 'São Paulo - SP ',
        'carroceria' : 'picape',
        'condição' : 'Seminovo',
        'tabela FIPE' : ''//não especificado no site
    },
    {
        'marca': 'Peugeot',
        'modelo': '208',
        'cor': 'preto',
        'ano': '2021',
        'preco': 'R$76.540,00',
        'km': '50.431',
        'localização': 'Juazeiro do Norte - CE',
        'carroceria' : 'hatch',
        'condição' : 'Seminovo',
        'tabela FIPE' : '73.815,00'
    },
    {
        'marca': 'JEEP',
        'modelo': 'Renegade',
        'cor': 'vermelho',
        'ano': '2019',
        'preco': 'R$79.900,00',
        'km': '40.973',
        'localização': 'Goiânia - GO',
        'carroceria' : 'SUV',
        'condição' : 'usado',
        'tabela FIPE' : 'R$78.071,00'
    },
    {
        'marca': 'Ford',
        'modelo': 'KA',
        'cor': 'prata',
        'ano': '2021',
        'preco': 'R$57.630,00',
        'km': '36.714',
        'localização': 'São Caetano do Sul - SP',
        'carroceria' : 'hatch',
        'condição' : 'Usado',
        'tabela FIPE' : 'R$54.053,00'
    },
    {
        'marca': 'Nissan',
        'modelo': 'Kicks',
        'cor': 'preto',
        'ano': '2021',
        'preco': 'R$95.900,00',
        'km': '46.522',
        'localização': 'Niterói - RJ',
        'carroceria' : 'SUV',
        'condição' : 'Usado',
        'tabela FIPE' : 'R$95.757,00'
    },
    //simulação - icarros:
    {
        'marca': 'Chevrolet',
        'modelo': 'Celta',
        'cor': 'branco',
        'ano': '2013',
        'preco': 'R$34.890,00',
        'km': '109.470',
        'localização': 'São Vicente - SP',
        'carroceria' : 'hatch',
        'condição' : 'usado',
        'tabela FIPE' : 'R$32.271,00'
    },
    {
        'marca': 'Peugeot',
        'modelo': '307',
        'cor': 'prata',
        'ano': '2011',
        'preco': 'R$32.990,00',
        'km': '177.542',
        'localização': 'São Paulo - SP',
        'carroceria' : 'hatch',
        'condição' : 'usado',
        'tabela FIPE' : 'R$29.505,00'
    },
    {
        'marca': 'Fiat',
        'modelo': 'Palio',
        'cor': 'prata',
        'ano': '2009',
        'preco': 'R$26.900,00',
        'km': '148.000',
        'localização': 'Porto Alegre - RS',
        'carroceria' : 'hatch',
        'condição' : 'Usado',
        'tabela FIPE' : 'R$24.431,00'
    },
    {
        'marca': 'Ford',
        'modelo': 'Fiesta',
        'cor': 'vermelho',
        'ano': '2012',
        'preco': 'R$30.900,00',
        'km': '208.000',
        'localização': 'São Paulo - SP',
        'carroceria' : 'hatch',
        'condição' : 'Usado',
        'tabela FIPE' : 'R$29.160,00'
    },
    {
        'marca': 'Citroen',
        'modelo': 'C3',
        'cor': 'branco',
        'ano': '2011',
        'preco': 'R$28.900,00',
        'km': '175.958',
        'localização': 'Curitiba - PR',
        'carroceria' : 'hatch',
        'condição' : 'Usado',
        'tabela FIPE' : 'R$26.517,00'
    },
    {
        'marca': 'Volkswagen',
        'modelo': 'Up',
        'cor': 'azul',
        'ano': '2016',
        'preco': 'R$58.900,00',
        'km': '30.000',
        'localização': 'Belém -PA',
        'carroceria' : 'hatch',
        'condição' : 'Usado',
        'tabela FIPE' : 'R$55.018,00'
    },
    {
        'marca': 'Hyundai',
        'modelo': 'HB20S',
        'cor': 'azul',
        'ano': '2015',
        'preco': 'R$49.900,00',
        'km': '145.000',
        'localização': 'São José dos Campos - SP',
        'carroceria' : 'hatch',
        'condição' : 'Usado',
        'tabela FIPE' : 'R$47.079,00'
    },
    {
        'marca': 'Kia',
        'modelo': 'Picanto',
        'cor': 'amarelo',
        'ano': '2011',
        'preco': 'R$32.900,00',
        'km': '85.461',
        'localização': 'Brasília - DF',
        'carroceria' : 'hatch',
        'condição' : 'Usado',
        'tabela FIPE' : 'R$32.549,00'
    },
    {
        'marca': 'Renault',
        'modelo': 'Kwid',
        'cor': 'laranja',
        'ano': '2019',
        'preco': 'R$46.990,00',
        'km': '65.000',
        'localização': 'Natal - RN',
        'carroceria' : 'hatch',
        'condição' : 'Usado',
        'tabela FIPE' : 'R$44.254,00'
    },
    {
        'marca': 'Nissan',
        'modelo': 'Frontier',
        'cor': 'laranja',
        'ano': '2017',
        'preco': 'R$46.990,00',
        'km': '161.289',
        'localização': 'Rio de Janeiro - RJ',
        'carroceria' : 'hatch',
        'condição' : 'USado',
        'tabela FIPE' : 'R$153.734,00'
    }
]

app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*'); // Permitir acesso de qualquer origem
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
    next();
});
  

app.post("/users", (req, res) => {
    
    const email = req.body.email
    const senha = req.body.senha
    
    const user = {email: email, senha: senha}
    
    users.push(user)
    
    res.json(users)
})
    

app.get("/users", (req, res) => {
    res.json(users)
})

app.listen(3000, () => console.log("up and running"))
