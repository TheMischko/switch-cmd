import dotenv from 'dotenv';

import app from './src/app.js';
import db from './src/db.js'

dotenv.config();

const PORT = process.env.APP_PORT || 8080;
let server;
db.initialize().then(() => {
    server = app.listen(PORT, () => console.log(`App running on port: ${PORT}`));
})
    .catch((error) => console.error(error));