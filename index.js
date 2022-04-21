import dotenv from 'dotenv';

import app from './src/app.js';
import {config as db_config} from './src/db.js';

dotenv.config();
db_config();

const PORT = process.env.APP_PORT || 8080;
let server;
server = app.listen(PORT, () => console.log(`App running on port: ${PORT}`));