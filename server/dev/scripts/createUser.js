'use strict'

const prompt = require('prompt')
const bcrypt = require('bcryptjs')
const crypto = require('crypto')

// Models
const models = require('../../models')

prompt.start()
prompt.get(
    [
        {
            name: 'name',
            description: 'Please enter your full name'
        },
        {
            name: 'email',
            description: 'Please enter your email address'
        },
        {
            name: 'phone',
            description: 'Please enter your phone number'
        }
    ], async function (err, result) {
        if (err) return console.log('An error occurred, please try again!')

        const newUser = {
            name: result.name,
            email: result.email,
            password: bcrypt.hashSync('caIsAw3some', 10),
            phone: result.phone,
            imageSource: null,
            role: 1,
            apiKey: crypto.randomBytes(16).toString('hex'),
            trustedDeviceId: null
        }

        console.log(`INSERT INTO Users (email, password, name, phone, role, apiKey) VALUES ('${newUser.email}', '${newUser.password}', '${newUser.name}', '${newUser.phone}', ${newUser.role}, '${newUser.apiKey}');`)

        // TODO --- Having issues getting the below to work...
        // Seems to be related to MySQL user privileges

        // try {
        //      // Verifies that this new user is unique (by email)
        //     if(await models.User.findOne({
        //         where: { email: newUser.email }
        //     }) === null) {

        //         // Ensures that this new user's api key is unique
        //         while(await models.User.findOne({
        //             where: { apiKey: newUser.apiKey }
        //         }) !== null ) {
        //             newUser.apiKey = crypto.randomBytes(16).toString('hex')
        //         }

        //         if(await createUser(newUser)) {
        //             return console.log('Success, user created.')
        //         } else {
        //             return console.log('Failure, an error occurred while attempting to create this user.')
        //         }
        //     } else {
        //         return console.log('Failure, a user with the specified email already exists!')
        //     }
        // } catch (err) {
        //     console.log(err)
        //     return console.log('An error occurred, please try again!')
        // }
})

async function createUser(newUser) {
    try {
        if(await models.User.create(newUser)) {
            return true
        } else {
            return false
        }
    } catch (err) {
        console.log(err)
        return false
    }
}