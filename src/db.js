import "reflect-metadata";
import {DataSource} from "typeorm";
import dotenv from "dotenv";

dotenv.config();

const database = new DataSource({
    type: "mysql",
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    username: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    entities: [],
    synchronize: true,
    logging: false,
});

export default database;