'use strict'

const moment = require('moment')

const deviceService = require('./device.server.service')
const locationService = require('./location.server.service')

const opts = {
    serialNumber: 'device - serialNumber',
    info: {
        serialNumber: 'serialNumber',
        hardwareUUID: 'hardwareUUID',
        modelName: 'modelName',
        modelIdentifier: 'modelIdentifier',
        modelNumber: 'modelNumber',

        status: 'status',
        timestamp: moment().toDate(),
        street: 'street',
        city: 'city',
        state: 'state',
        zip: 'zip',
        country: 'country',
        latitude: 'latitude',
        longitude: 'longitude',

        name: 'name'
    }
}

locationService.updateLocation(opts, (error, result) => {
    if(error) return console.log(error)
    console.log(result)
})

// deviceService.registerDevice(opts, (error, result) => {
//     if(error) return console.log(error)
//     console.log(result)
// })

// deviceService.getInventory(null, (error, inventory) => {
    // if(err) return console.log(error)
    // console.log(inventory)
// })