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