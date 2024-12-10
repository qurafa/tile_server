const { Client } = require('pg');
const Postgis = require('postgis');

const client = new Client({
    connectionString: "postgres://postgres:password@localhost:5432/AB_Calgary_East_utm12_2020"
});
client.connect();

const postgis = new Postgis(client);

async function run() {
    try{
        
    } catch (err){
        
    } finally{
        client.end();
    }
}