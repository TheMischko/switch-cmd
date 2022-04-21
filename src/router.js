import PostRouter from "./Routers/PostRouter.js"

export const routerInit = (app) => {
    app.use('/posts', PostRouter);
}