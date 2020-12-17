'use strict'

const deviceService = require('../services/device.server.service')

/**
 * Registers a new CA device. Saving this device's system information, location information, 
 * and "holder" (the owner) to the database.
 * 
 * Devices are uniquely identified by their serial number. 
 * 
 * Returns true on success; otherwise status 500 along with the error is returned on any failure.
 */
exports.registerDevice = async function(req, res) {
    const info = req.body
    const opts = {
        info: info
    }
    deviceService.registerDevice(opts, (err, result) => {
        if(err) return res.status(500).send(err)
        res.status(200).send(result)
    })
}

/**
 * Gets all registered inventory. Each inventory record will be the combined reference between
 * the Device, Location, and Holder models. 
 * 
 * Note: only the most recent location will be reported for each device (not its entire location history)
 * 
 * Returns a list of each registered inventory record on success; otherwise status 500 allong with the
 * error is returned on any failure.
 */
exports.getInventory = async function(req, res) {
    deviceService.getInventory(null, (err, inventory) => {
        if(err) return res.status(500).send(err)
        res.status(200).send(inventory)
    })
}