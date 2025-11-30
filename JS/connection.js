import mysql from "mysql2";

export const pool = mysql.createPool({
    host: "localhost",
    user: "root",
    password: "123456",
    database: "frostfixpro",
    port: 3306
}).promise();
export default pool;
