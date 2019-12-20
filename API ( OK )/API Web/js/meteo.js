const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => res.send('API de la station météo'))

app.get('/temperature', (req, res) => {

    const mariadb = require('mariadb');
    const pool = mariadb.createPool({ host: "localhost", user: "root", password: "password", connectionLimit: 5 });

    async function asyncFunction() {
        let conn;
        try {

            conn = await pool.getConnection();
            const rows = await conn.query("SELECT * from T_DONNEES");
            res.send(JSON.stringify(row));
            const res = await conn.query("INSERT INTO myTable value (?, ?)", [1, "mariadb"]);
            res: { affectedRows: 1, insertId: 1, warningStatus: 0 }

        } catch (err) {
            throw err;
        } finally {
            if (conn) conn.release(); //release to pool
        }
    }

})

app.post('/temperature', (req, res) => {
    const mariadb = require('mariadb');
    const pool = mariadb.createPool({ host: "localhost", user: "cody", password: "password", connectionLimit: 5 });

    async function asyncFunction() {
        let conn;
        try {

            conn = await pool.getConnection();
            result = await conn.query("INSERT INTO T_DONNEES value (?, ?)", [10, 50]);
            res.send(JSON.stringify(result));

        } catch (err) {
            throw err;
        } finally {
            if (conn) conn.release(); //release to pool
        }
    }
})


app.listen(port, () => console.log(`Example app listening on port ${port}!`))