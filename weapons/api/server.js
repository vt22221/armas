const express = require('express');
const app = express();
const cors = require('cors');
app.use(cors());
app.use(express.json());

// Simulação de DB
let inventories = {};

// Endpoint para consultar inventário
app.get('/api/inventory/:player', (req, res) => {
    let player = req.params.player;
    res.json({inventory: inventories[player] || []});
});

// Endpoint para atualizar inventário (seguro via JWT na real)
app.post('/api/inventory/:player', (req, res) => {
    let player = req.params.player;
    inventories[player] = req.body.inventory;
    res.json({ok: true});
});

// Webhook para eventos importantes
app.post('/api/webhook/event', (req, res) => {
    // Notificação Discord, analytics etc
    res.json({ok: true});
});

app.listen(3100, ()=>console.log("API ForgeX rodando na porta 3100"));