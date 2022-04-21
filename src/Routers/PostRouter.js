import express from "express";

import Post from "../Models/Post.js"

const router = express.Router();

router.use((req, res, next) => {
    console.log("PostRouter.js");
    next();
});

// GET on root '/'
router.get('/', async (req, res) => {
    const posts = await Post.query();
    res.send(posts);
});

// GET post with id
router.get('/:postId', async (req, res) => {
    const posts = await Post.query().findById(req.params.postId);
    res.send(posts);
});

router.post('/add', async (req, res) => {
    const post = {...req.body};
    const result = await Post.query().insert(post);
    res.send(result);
})

export default router;