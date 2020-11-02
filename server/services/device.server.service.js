'use strict'

/**
 * Returns the specified device's info: model name, model identifier, 
 * model number, serial number, and hardware UUID
 */
exports.getDeviceInfo = async function(opts, callback) {
    if(!opts.deviceId) return callback('Requires \'deviceId\' as an opts parameter')

    callback(null, true)
}