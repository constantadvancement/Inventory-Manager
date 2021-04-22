'use strict'

const inventoryService = require('../services/inventory.server.service')

/* --------------- iOS app controllers --------------- */

/**
 * Gets all registered inventory. Each inventory record will be the combined reference between
 * the Device, Location, and Holder models. 
 * 
 * Returns a list of each registered inventory record on success; otherwise status 500 along 
 * with the error is returned on any failure.
 */
exports.getInventory = async function(req, res) {
    inventoryService.getInventory(null, (err, inventory) => {
        if(err) return res.status(500).send(err)
        res.status(200).send(inventory)
    })
}

/**
 * Unregisters the inventory record corresponding to the provided device serial number. Removing
 * all associated Device, Location, and Holder records.
 * 
 * Returns true on success; otherwise status 500 along with the error is returned on any failure.
 */
exports.unregisterDevice = async function(req, res) {
    const serialNumber = req.params.serialNumber
    const opts = {
        serialNumber: serialNumber
    }
    inventoryService.unregisterDevice(opts, (err, result) => {
        if(err) return res.status(500).send(err)
        res.status(200).send(result)
    })
}

/* --------------- macOS app controllers --------------- */

/**
 * Returns success; approving this api key. The "ApiKeyAuth" middleware handles verification.
 */
exports.verifyApiKey = async function(req, res) {
    res.status(200).send(true)
}

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
    inventoryService.registerDevice(opts, (err, result) => {
        if(err) return res.status(500).send(err)
        res.status(200).send(result)
    })
}

/**
 * Updates the specified device's location. This includes its address, coordinates, 
 * location permission status, and a timestamp. 
 * 
 * Returns true on success; otherwise status 500 along with the error is returned on any failure.
 */
exports.updateLocation = async function(req, res) {
    const serialNumber = req.params.serialNumber
    const info = req.body
    const opts = {
        serialNumber: serialNumber,
        info: info
    }
    inventoryService.updateLocation(opts, (err, result) => {
        if(err) return res.status(500).send(err)
        res.status(200).send(result)
    })
}