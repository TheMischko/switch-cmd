import express from 'express';
import morgan from 'morgan';
import cors from 'cors';

const app = express();

app.use(express.json());
app.use(express.urlencoded({extended: true}));

// request logging
app.use(morgan("tiny"));

// enable CORS
app.use(cors());
app.options('*', cors());

export default app;