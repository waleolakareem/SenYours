# Senyours
#### Defeating Loneliness One Person At A Time.
  > "The surest sign of age is loneliness." - Annie Dillard


  > "A strong team can take any crazy vision and turn it into reality".- John Carmack

## Developers:
### Git Version Management (Branches):
  * []()
### Deploying to Development:
  * []()
### Required Technologies:
  * [Ruby](https://www.ruby-lang.org/en/) Version: `ruby 2.3.4p301 (2017-03-30 revision 58214) [x86_64-darwin16]`.
  * [Rails](https://rubyonrails.org/) Version: `Rails 5.1.4`.
  * Database(s): [PostgreSQL](https://www.postgresql.org/), [Amazon S3](https://aws.amazon.com/s3/).
  * []()
### App Dependencies:
  * [Survey.js](https://surveyjs.io/Overview/Library/)
  * [Prefinery](https://www.prefinery.com/)
### API References:
  * [Stripe API](https://stripe.com/docs/api)
  * [Accurate Background API](https://resources.accurate.com/background-check-api)
### Required Test Suites:
  * []()
### Credited Contributions:
  * [Social Media Icons](https://github.com/bradvin/social-share-urls)


### BLANK
### BLANK


## WARNING ##
- Do not merge your branch to development.
- Only make a pull request of your branch to development and let team lead merge to development.

## Prerequisites
If you get the error "Jquery cannot be defined"

**Yarn install Jquery** will solve this issue
____
**.env Creation**

- Create a file inside the Senyours App
- Name it .env
- Insert all keys into .env

If you get an error similar to:
> The engine "node" is incompatible with this module. Expected version ">=4 <=9".

when running `yarn add jquery`

- Delete package-lock.json and yarn.lock
- run `yarn install`
- run `npm install`
- retry `yarn add jquery`

# Deployment
- Merge to development branch
- Merge development to master
- push to heroku senyoursdevtest
- Wait 72 Hours before pushing to Senyours Production
