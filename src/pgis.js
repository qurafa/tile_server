const { Client } = require('pg');
const Postgis = require('postgis');

const client = new Client({
    connectionString: "postgres://postgres:Helicraft1@localhost:5432/postgres"
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