const express = require('express');

const app = express();

const port = 8000 || process.env.PORT;

const cors = require('cors');

const bodyParser = require('body-parser');

const mongoose = require('mongoose');

const userroute = require('./routes/user_route');

app.use(cors());

app.use(bodyParser.urlencoded({ extended: true }));

app.use(bodyParser.json());

mongoose.connect("mongodb+srv://chirag:chirag123@cluster0.z8kell5.mongodb.net/?retryWrites=true&w=majority", { useNewUrlParser: true, useUnifiedTopology: true });

app.use('/', userroute);


app.listen(port, () => {
    console.log(`listening on ${port}`);
})