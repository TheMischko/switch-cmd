import app from './src/app.js';
import dotenv from 'dotenv';

dotenv.config();

let server = app.listen(process.env.APP_PORT || 8080);