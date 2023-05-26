const express = require("express");
const { userRoutes } = require("./routes/routes");

const app = express();

app.use(express.json());
app.use(userRoutes);

app.listen(3000, ()=> console.log('started server localhost: port 3000'))