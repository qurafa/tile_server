const express = require("express");
const cors = require("cors");

let port = 3000;

const app = express();
app.use(cors());

app.get('/', (req, res) => {
    res.send('Testing response!');
    res.end();
});

app.listen(port, () => {
    console.log(`Tile server running on port ${port}`)
});