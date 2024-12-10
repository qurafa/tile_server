const express = require("express");
const cors = require("cors");
const sqlite3 = require("sqlite3");

let port = 3000;

const app = express();
app.use(cors());

app.get('/', (req, res) => {
    res.send('Testing response!');
});

app.listen(port, () => {
    console.log(`Tile server running on port ${port}`)
});