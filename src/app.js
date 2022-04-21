import express from 'express';
import morgan from 'morgan';
import cors from 'cors';

import {routerInit} from './router.js'

const app = express();

app.use(express.json());
app.use(express.urlencoded({extended: true}));

// request logging
app.use(morgan("tiny"));

// enable CORS
app.use(cors());
app.options('*', cors());

// router
routerInit(app);
export default app;