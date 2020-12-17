'use strict'

// Models
const models = require('../models')

/**
 * Updates the specified device's location. This includes its address, coordinates, 
 * location permission status, and a timestamp. 
 * 
 * Returns true on success.
 */
exports.updateLocation = async function(opts, callback) {
    if(!opts.serialNumber) return callback('Requires \'serialNumber\' as an opts parameter')
    if(!opts.info) return callback('Requires \'info\' as an opts parameter')

    console.log("Updating location...")

    const locationData = {
        timestamp: opts.info.timestamp,
        status: opts.info.status,
        street: opts.info.street,
        city: opts.info.city,
        state: opts.info.state,
        zip: opts.info.zip,
        country: opts.info.country,
        latitude: opts.info.latitude,
        longitude: opts.info.longitude
    }

    try {
        // Check if this device exists
        if(await models.Device.findOne({
            where: { serialNumber: opts.serialNumber }
        }) === null) return callback(null, false)

        // Create a new location entry for this device
        locationData['deviceSerialNumber'] = opts.serialNumber
        await models.Location.create(locationData)

        callback(null, true)
    } catch (error) {
        callback(error, null)
    }
}