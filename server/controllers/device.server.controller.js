'use strict'

const deviceService = require('../services/device.server.service')

/**
 * Returns the specified device's info: model name, model identifier, 
 * model number, serial number, and hardware UUID
 */
exports.getDeviceInfo = async function(req, res) {
    const deviceId = req.params.deviceId
    const body = req.body
    console.log(body)
    const opts = {
        deviceId: deviceId
    }
    deviceService.getDeviceInfo(opts, (err, modelName) => {
        if(err) return res.status(500).send(err)
        res.status(200).send(modelName)
    })
}