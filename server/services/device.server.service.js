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

    const holderData = {
        name: opts.info.name,
        email: opts.info.email,
        phone: opts.info.phone
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

/**
 * Gets all registered inventory. Each inventory record will be the combined reference between
 * the Device, Location, and Holder models. 
 * 
 * Note: only the most recent location will be reported for each device (not its entire location history)
 * 
 * Returns a list of each registered inventory record on success.
 */
exports.getInventory = async function(opts, callback) {
    console.log("Getting inventory...")

    try {
        let inventoryList = []

        // Gets a list of all registered devices
        const devices = await models.Device.findAll({ 
            attributes: { exclude: ['createdAt', 'updatedAt'] },
            nest: true, raw: true 
        })

        for(const device of devices) {
            // Gets this device's holder
            const holder = await models.Holder.findOne({
                where: { deviceSerialNumber: device.serialNumber },
                attributes: { exclude: ['id', 'deviceSerialNumber', 'createdAt', 'updatedAt'] },
                nest: true, raw: true
            })

            // Gets this device's (most recent) location
            const location = await models.Location.findAll({
                limit: 1,
                order: [[ 'timestamp', 'DESC' ]],
                where: { deviceSerialNumber: device.serialNumber },
                attributes: { exclude: ['id', 'deviceSerialNumber', 'createdAt', 'updatedAt'] },
                nest: true, raw: true
            })

            // Adds this device's information to the inventory list
            inventoryList.push({
                device: device,
                holder: holder,
                location: location[0]
            })
        }

        console.log(inventoryList)

        callback(null, inventoryList)
    } catch (error) {
        callback(error, null)
    }
}
