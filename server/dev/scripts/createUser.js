'use strict'

const bcrypt = require('bcryptjs')

// Models
const user = require('../../models').User

const defaultUser = {
    name: 'Ryan Mackin',
    email: 'test@email.com',
    password: bcrypt.hashSync('password', 10),
    phone: '123-456-7890',
    imageSource: null,
    role: 1,
    apiKey: 'c2810191-72e6-423c-a60a-0e61423144af'
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