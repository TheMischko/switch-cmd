import PostRouter from "./Routers/PostRouter.js"
import AuthenticationRouter, {authenticateToken} from "./Routers/AuthenticationRouter.js";

export const routerInit = (app) => {
    app.use(authenticateToken);
    app.use('/posts', PostRouter);
    app.use('/auth', AuthenticationRouter);
}