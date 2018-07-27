# Senyours - Defeating Loneliness One Person At A Time.
  > "The surest sign of age is loneliness." - Annie Dillard

## Developers:
  > "A strong team can take any crazy vision and turn it into reality".- John Carmack

#### Git Version Management (Branches):
  * Our git version management is based off this [Article](http://markshust.com/2018/04/07/introducing-git-ship-simplified-git-flow-workflow) and is similar to normal convention, with some steps removed for simplified small team flow.
  * All branches will now be preceeded with a small "tag" (`senyours`,`release`,`bug`,`feat`).
    * Example Branches:
      * Master: `senyours/<release_number>` i.e. `senyours/2.0`.
      * Release: `release/<release_number>` i.e. `release/2.0`.
      * Hotfix: `bug/<bug_name>` i.e. `bug/broken_link`
      * Feature: `feat/<feature_name>` i.e. `feat/my_new_feature`
    * The _Master_ branch __only ever__ represents finished _Release_ branches (I.E. `SenYours 1.1`).
    * _Release_ branches are created every new sprint (usually 2 weeks) & are merged back into the the _Master_ branch. __Merging into Master is only done by the CEO or CTO.__
    * Branching off from _Releases_ are _Feature_ branches. These represent single features for that specific _Release_. These will merge back into the original _Release_ branch.
    * _Hotfix_ branches branch off from a _Release_ if there is a severe bug. (i.e. "If the use enters the konami code our program will reformat the main harddrive..."). When resolved, it is merged back into that _Release_ branch.
  * Note: `/` is used to divide names to help with future searches (if needed). This is the same reason we are adding tags to our branches. [Read more if your interested...](https://stackoverflow.com/a/6065944/10090036)

#### Pulling from & Pushing to Releases:
  * Let's say you've created a new feature branch called `feat/this_new_thing` and now you need to merge it into `release/1.1`. There are a few thing you should do:
    * First: You should pull the release branch into your feature branch to check for merge conflicts.
      * Instruction: While in your _Feature_ branch `feat/this_new_thing` you should use the command `git pull origin release/1.1`.
    * Second: If there were merge conflicts their exact locations will be noted in your terminal. Go to those files and resolve the conflicts. When done with ALL merge conflicts, perform an additional commit to your branched like so `git commit -m "Merged with release/1.1"`.
    * Third: Now that there are no more conflicts (provided you had any at all) you will now make a pull request in github to the current sprint's release branch.
  * If you have questions on version control please contact Blaine (He is more than happy to help, cause version control sucks!).

#### Technologies:
  * [Ruby](https://www.ruby-lang.org/en/) Version: `ruby 2.3.4p301 (2017-03-30 revision 58214) [x86_64-darwin16]`.
  * [Rails](https://rubyonrails.org/) Version: `Rails 5.1.4`.
  * Database(s): [PostgreSQL](https://www.postgresql.org/), [Amazon S3](https://aws.amazon.com/s3/).
  * Ruby Gems:
    * ~~~ ADD ALL GEM TECHNOLOGIES HERE ~~~
    * []()
#### App Dependencies & API's:
  * [Survey.js](https://surveyjs.io/Overview/Library/)
  * [Prefinery](https://www.prefinery.com/)
  * [Stripe API](https://stripe.com/docs/api)
  * [Accurate Background API](https://resources.accurate.com/background-check-api)
#### Required Test Suites:
  * []()
#### Credited Contributions:
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
