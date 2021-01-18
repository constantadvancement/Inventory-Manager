'use strict'

const bcrypt = require('bcryptjs')

// Models
const user = require('../../models').User

const defaultUser = {
    email: 'test@email.com',
    password: bcrypt.hashSync('password', 10),
    role: 1,
    apiKey: 'some_api_key'
}

async function createUser() {
    try {
        if(await user.create(defaultUser)) {
            return console.log("Success, user created.")
        } else {
            return console.log("Failure, user was not created.")
        }
    } catch (err) {
        console.log(err)
    }
}

createUser()