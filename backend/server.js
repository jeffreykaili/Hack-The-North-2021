const express = require('express');
const app = express();
const routes = require('./routes');
app.use(express.json());
app.use(express.urlencoded());



routes(app); //contains all the API routes in routes.js

let port = process.env.PORT || 8000;
app.listen(port, () => {
    console.log(`Server listening at http://localhost:${port}`)
  });