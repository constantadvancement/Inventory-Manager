'use strict'

/**
 * This file is used to initialize all database tables
 */

async function initDb() {
    await require('./loadModels') ();

    process.exit();
}

initDb();