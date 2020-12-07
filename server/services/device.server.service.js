'use strict'

// Models
const models = require('../models')

/**
 * Registers a new CA device. Saving this device's system information, location information, 
 * and "holder" (the owner) to the database.
 *  
 * Returns true on success.
 */
exports.registerDevice = async function(opts, callback) {
    if(!opts.info) return callback('Requires \'info\' as an opts parameter')

    console.log("Registering a new device...")

    const deviceData = {
        serialNumber: opts.info.serialNumber,
        hardwareUUID: opts.info.hardwareUUID,
        modelName: opts.info.modelName,
        modelIdentifier: opts.info.modelIdentifier,
        modelNumber: opts.info.modelNumber
    }

    const locationData = {
        status: opts.info.status,
        timestamp: opts.info.timestamp,
        street: opts.info.street,
        city: opts.info.city,
        state: opts.info.state,
        zip: opts.info.zip,
        country: opts.info.country,
        latitude: opts.info.latitude,
        longitude: opts.info.longitude
    }

    const holderData = {
        name: opts.info.name
    }

    try {
        // Check if this device has already been registered
        if(await models.Device.findOne({
            where: { serialNumber: deviceData.serialNumber }
        })) return callback(null, false)

        // Register this device

        // 1) Create device entry
        const device = await models.Device.create(deviceData)

        // 2) Create location entry for this device
        locationData['deviceSerialNumber'] = device.serialNumber
        await models.Location.create(locationData)

        // 3) Create holder entry for this device
        holderData['deviceSerialNumber'] = device.serialNumber
        await models.Holder.create(holderData)

        callback(null, true)
    } catch (error) {
        callback(error, null)
    }
}


