# Senyours Application

> "A strong team can take any crazy vision and turn it into reality".
                                            - John Carmack


## WARNING ##
- Do not merge your branch to development.
- Only make a pull request of your branch to development and let team lead merge to development.

## Prerequisites ##
If you get the error "Jquery cannot be defined"

**Yarn install Jquery** will solve this issue
____
**.env Creation**

- Create a file inside the Senyours App
- Name it .env
- Insert all keys into .env
- Ruby Version - ruby 2.3.4p301 (2017-03-30 revision 58214) [x86_64-darwin16]
- Rails Version - Rails 5.1.4
- Database - Postgres SQL, S3 storage

If you get an error similar to:
> The engine "node" is incompatible with this module. Expected version ">=4 <=9".

when running `yarn add jquery`

- Delete package-lock.json and yarn.lock
- run `yarn install`
- run `npm install`
- retry `yarn add jquery`

# Dependencies
- Survey.js
- Prefinery



# API
- Stripe
- Accurate background API

# Deployment
- Merge to development branch
- Merge development to master
- push to heroku senyoursdevtest
- Wait 72 Hours before pushing to Senyours Production

# Test Suite
_Coming Soon_

# Resource Contribution Credit
- Social Media Icons: https://github.com/bradvin/social-share-urls#google
