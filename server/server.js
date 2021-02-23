'use strict'

const config = require('./config/config.server')
const port = config.port

const express = require('./config/express')
const app = express()

// Cron tasks
const tasks = require('./cron/tasks');
tasks.start()

app.listen(port, () => console.log(`Listening on port ${port}.`))