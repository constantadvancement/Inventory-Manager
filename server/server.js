'use strict'

const config = require('./config/config.developer')
const port = config.port

const express = require('./config/express')
const app = express()

app.listen(port, () => console.log(`Listening on port ${port}.`))