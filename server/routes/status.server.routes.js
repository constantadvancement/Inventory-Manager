'use strict'

const moment = require('moment')

// Simple server status checker route
module.exports = (app) => {
    app.get('/status', async (req, res) => {
        res.status(200).send({ status: "Alive!", timestamp: moment().format('LLLL') })
    })
}