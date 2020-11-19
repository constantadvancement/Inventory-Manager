'use strict'

const deviceService = require('../services/device.server.service')

/**
 * Registers a new device's system information
 */
exports.registerDeviceInfo = async function(req, res) {
    const body = req.body
    const opts = {
        info: body
    }
    deviceService.registerDeviceInfo(opts, (err, result) => {
        if(err) return res.status(500).send(err)
        res.status(200).send(result)
    })
}

exports.ping = async function(req, res) {
    const fs = require('fs')
    const path = require('path')

    try {
        const data = fs.readFileSync(path.join(__dirname, '/test.txt'), 'utf8')
    
        console.log("I was pinged...")
        fs.writeFileSync(path.join(__dirname, '/test.txt'), data + '\nPing... ('+ Date.now()+')')

        res.status(200).send(true)
      } catch (err) {
        console.error(err)

        res.status(500).send(false)
      }
}