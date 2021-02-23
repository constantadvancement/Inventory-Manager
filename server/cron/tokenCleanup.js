'use strict'

const cron = require('node-cron')
const moment = require('moment')
const { Op } = require('sequelize')

// Models
const models = require('../models')

/**
 * Returns a cron task that will remove all expired password reset tokens from the database; 
 * this task will run once everyday at 3 am.
 */
exports.passwordResetTokenCleanup = function() {
    // Cron task runs everyday at 3 am
    const task = cron.schedule('0 3 * * *', async () => {
        console.log('Password Reset Token Cleanup: starting... (' + moment().toDate() + ')')
        let removed = 0
        try {
            // Gets all password reset tokens that are expired
            const passwordResetTokens = await models.PasswordResetTokens.findAll({
                where: { expiresAt: { [Op.lte]: moment().toDate() } }
            })
    
            for(const token of passwordResetTokens) {
                try {
                    await token.destroy()
                    removed++
                } catch (err) {
                    console.log('An error occured while removing token id: ' + token.id)
                    console.log(err)
                }
            }
            console.log('Password Reset Token Cleanup: ending... (' + moment().toDate() + ') ' + removed + ' password reset tokens were removed.');
        } catch (err) {
            console.log('Password Reset Token Cleanup: ending... (' + moment().toDate() + ') error, ' + err);
        }
    })

    return task
}