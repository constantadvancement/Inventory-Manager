'use strict'

const bcrypt = require('bcryptjs')

// Models
const user = require('../../models').User

const defaultUser = {
    email: 'test@email.com',
    password: bcrypt.hashSync('password', 10),
    image: false,
    role: 1,
    apiKey: 'some_api_key___TODO_need_to_auto_generate_some_random_string'
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