'use strict'

const tokenCleanup = require('./tokenCleanup');

/**
 * Starts all reccuring cron tasks for the server.
 */
exports.start = () => {
    const passwordResetTask = tokenCleanup.passwordResetTokenCleanup()
    passwordResetTask.start()
}
