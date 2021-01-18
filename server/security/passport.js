'use strict'

const bcrypt = require('bcryptjs')

// Authentication strategy
const LocalStrategy = require('passport-local').Strategy

// Models
const User = require('../models').User

module.exports = function initializePassport(passport) {
    // Local authentication
    passport.use(new LocalStrategy({
        usernameField: 'email', session: false
    }, async (email, password, done) => {
        try {
            const user = await User.findOne({
                where: { email: email }
            })

            // Local user does not exist; failure
            if(user === null) {
                return done(null, false, { message: 'No user with this email' })
            }

            // Local user exists; verify password
            if(await bcrypt.compare(password, user.password)) {
                // Valid password; success
                return done(null, user)
            } else {
                // Invalid password; failure
                return done(null, false, { message: 'User password is incorrect' })
            }
        } catch (err) {
            return done(err, null)
        }
    }))

    passport.serializeUser((user, done) => {
        done(null, user.id)
    })

    passport.deserializeUser(async (id, done) => {
        try {
        const user = await User.findOne({
            where: { id: id }
        })

        return done(null, user);
        } catch (err) {
        done(err, null)
        }
    })
}
