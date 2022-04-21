import {Model} from "objection";
import Knex from "knex";
import dotenv from "dotenv";

dotenv.config();
let knex;
export const config = () => {
    knex = Knex({
        client: 'mysql2',
        useNullAsDefault: true,
        connection: {
            host: process.env.DB_HOST,
            port: process.env.DB_PORT,
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,
            database: process.env.DB_DATABASE,
        }
    });

    Model.knex(knex);
}

export default knex;