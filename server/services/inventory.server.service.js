'use strict'

const moment = require('moment')

// Models
const models = require('../models')

/* --------------- iOS app services --------------- */

/**
 * Gets all registered inventory. Each inventory record will be the combined reference between
 * the Device, Location, and Holder models. 
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
            order: [[ 'createdAt', 'ASC' ]],
            nest: true, raw: true 
        })

        for(const device of devices) {
            // Gets this device's holder
            const holder = await models.Holder.findOne({
                where: { deviceSerialNumber: device.serialNumber },
                attributes: { exclude: ['id', 'deviceSerialNumber', 'createdAt', 'updatedAt'] },
                nest: true, raw: true
            })

            // Gets this device's reported locations
            const locations = await models.Location.findAll({
                order: [[ 'timestamp', 'DESC' ]],
                where: { deviceSerialNumber: device.serialNumber },
                attributes: { exclude: ['id', 'deviceSerialNumber', 'createdAt', 'updatedAt'] },
                nest: true, raw: true
            })

            for(const location of locations) {
                // Formats this locations timestamp
                location.timestamp = moment(location.timestamp).format('LLLL').toString()
            }

            // Adds this device's information to the inventory list
            inventoryList.push({
                device: device,
                holder: holder,
                locations: locations
            })
        }

        console.log(inventoryList)
        callback(null, inventoryList)
    } catch (error) {
        callback(error, null)
    }
}

/**
 * unregisters the inventory record corresponding to the provided device serial number. Removing
 * all associated Device, Location, and Holder records.
 * 
 * Returns true on success.
 */
exports.unregisterDevice = async function(opts, callback) {
    if(!opts.serialNumber) return callback('Requires \'serialNumber\' as an opts parameter')

    try {
        // Deletes the device (and all associated records) that belong to the provided serial number
        const result = await models.Device.destroy({ 
            where: { serialNumber: opts.serialNumber },
            nest: true, raw: true
        })

        if(result === 0) {
            // Failure; no device was deleted
            callback(null, false)
        } else {
            // Success; device was deleted
            callback(null, true)
        }
    } catch (err) {
        callback(err, null)
    }
}

/* --------------- macOS app services --------------- */

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
        timestamp: opts.info.timestamp || moment().toDate(),
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
        timestamp: opts.info.timestamp || moment().toDate(),
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