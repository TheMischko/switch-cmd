import express from "express";
import jwt from "jsonwebtoken";
import {passwordHash, passwordVerify} from "nodejs-password";
import dotenv from "dotenv";

import User from "../models/User.js";

dotenv.config();

const router = express.Router();

router.get('/login', async (req, res) => {
    const user = getUserFromRequest(req);
    let dbPassword = "";
    try {
        dbPassword = await User.query().select("password").where(builder => builder.where("email", user.email ?? "").orWhere("username", user.username ?? ""))
    } catch (err) {
        res.sendStatus(400);
    }

    passwordVerify(user.password, dbPassword, process.env.ACCESS_TOKEN_SECRET)
        .then((wasCorrect) => {
            if (!wasCorrect) {
                res.sendStatus(400);
            }
            const accessToken = createToken(user);
            res.json({accessToken: accessToken});
            res.sendStatus(200);
        })
        .catch((error) => {
            if (error) res.sendStatus(400);
        });

});

router.put("/register", async (req, res) => {
    const date = new Date();
    const password = await passwordHash(req.body.password, date.getMilliseconds().toString());
    const user = await User.query().insert({
        username: req.body.username ?? "",
        password: password,
        email: req.body.email
    });

    const accessToken = createToken(user.toJSON());
    res.json({accessToken: accessToken});
});

export default router;

export const authenticateToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
    if (process.env.NODE_ENV === "production")
        if (token == null) return res.sendStatus(401);
        else
            console.log("Unauthorized access.");

    jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, user) => {
        if (process.env.NODE_ENV === "production")
            if (err) return res.sendStatus(403);
        req.user = user;
        next();
    });
};

const createToken = (user) => {
    const date = new Date();
    return jwt.sign(user, process.env.ACCESS_TOKEN_SECRET);
};

const getUserFromRequest = (req) => {
    let username = req.body.username;
    let email = req.body.email;
    let password = req.body.password
    return {
        username, email, password
    }
};