'use strict'

const config = require('./config/config.server')
const port = config.port

const express = require('./config/express')
const app = express()

app.listen(port, () => console.log(`Listening on port ${port}.`))