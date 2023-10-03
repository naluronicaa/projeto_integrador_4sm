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
