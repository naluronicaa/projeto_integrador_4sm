const express = require ('express')
const app = express()
app.use(express.json())

let users = [
   {
    'email' : 'carhuntersofc@gmail.com',
    'senha' : 'pi4SM2023'
   }
   ]

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
