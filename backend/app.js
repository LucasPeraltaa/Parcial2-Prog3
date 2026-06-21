const express = require("express");
const cors = require("cors");
require("dotenv").config();

const conexion = require("./config/db");

const app = express();

app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
    res.send("API Kiosko funcionando");
});

app.get("/productos", (req, res) => {

    const sql = "SELECT * FROM productos";

    conexion.query(sql, (error, resultados) => {

        if (error) {
            return res.status(500).json(error);
        }

        res.json(resultados);
    });

});

const PORT = process.env.PORT;

app.listen(PORT, () => {
    console.log(`Servidor corriendo en puerto ${PORT}`);
});