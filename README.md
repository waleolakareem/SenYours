# Senyours - Defeating Loneliness One Person At A Time.
  > "The surest sign of age is loneliness." - Annie Dillard

  Senyours is a platform that connects verified companions with senior adults that need companionship care, help shopping, transportation and even travel assistance. Senyours is a one-stop shop for senior adults.

## Developers:
  > "A strong team can take any crazy vision and turn it into reality".- John Carmack
  > "The difference between a successful person and others is not a lack of strength, not a lack of knowledge, but rather a lack of will."- Vince Lombardi

## Planned Sprints:
##### [release/3.0] (Aug 19th - Aug 26th): [Stripe Error Catching & Complete Testing Suite]
    * Redesign Profile Overview using AJAX for a seamless experience (Specific Sections to AJAX: Services, Personal Information, Reviews, Calendar, Transactions).
    * Clean up backend coding wherever required & Add commented code blocks wherever required. This is a very open-ended task.
##### [release/4.0] (Aug 26th+): [Frontend Elderly Simplification]
    * Implement all error catching for Stripe.
    * Generate Testing for all previous Models & Controllers.
    * Implement all Webhook related database updates for Stripe.
    * Simplify & Streamline Signup & Login (For Seniors specifically).
    * Redesign & add signup/login links to Senior & Companion pages (/super_adult & /companion)
    * Implement "Guardian" status for users to sign up their "seniors" and manage their "Senior" accounts.
##### Additional Sprints / Stretch Goals (No set timeframes)
    * Mobile Oriented / Mobile App
    * Add a toggle to allow Users to switch from "Guardian" to "Companion" status.

## Completed Sprints:
##### [release/1.0] (July 30th - Aug 5th): [Backend Rework]
    * ☑ Implement Testing Technologies (RSpec, SimpleCov).
    * ☑ Controller "available_days" has been reworked with new routes (set_date_unavailable, set_date_available, time_sheet, close_time_sheet) and two additonal routes for use in sprint 2 (set_time_unavailable, set_time_available).
    * ☑ Views in available_days ahve been ajax-ifed (calendar, set_date_available, set_date_unavailable, set_time_available, set_time_unavailable, time_sheet, close_time_sheet).
##### [release/2.0] (Aug 6th - Aug 19th): [Stripe Implementation & Profile Overhaul]
    * ☑ Implement all Charge/Refund/Transfer related actions Stripe.

#### Git Version Management (Branches):
  * Our git version management is based off this [Article](http://markshust.com/2018/04/07/introducing-git-ship-simplified-git-flow-workflow) and is similar to normal convention, with some steps removed for simplified small team flow.
  * All branches will now be preceeded with a small "tag" (`senyours`,`release`,`bug`,`feat`).
    * Example Branches:
      * Master: `senyours/<release_number>` i.e. `senyours/2.0`.
      * Release: `release/<release_number>` i.e. `release/2.0`.
      * Hotfix: `bug/<bug_name>` i.e. `bug/broken_link`
      * Feature: `feat/<feature_name>` i.e. `feat/my_new_feature`
        * All branch names should be 1-3 words long at maximum.
    * The _Master_ branch __only ever__ represents finished _Release_ branches (i.e. `SenYours 1.1`).
    * _Release_ branches are created every new sprint (usually 2 weeks) & are merged back into the the _Master_ branch. __Merging into Master is only done by the CEO or CTO.__
    * Branching off from _Releases_ are _Feature_ branches. These represent single features for that specific _Release_. These will merge back into the original _Release_ branch.
    * _Hotfix_ branches branch off from a _Release_ branch if there is a severe bug. (i.e. "If the use enters the konami code our program will reformat the main harddrive..."). When resolved, it is merged back into that _Release_ branch.
  * Note: `/` is used to divide names to help with future searches (if needed). This is the same reason we are adding tags to our branches. [Read more if your interested...](https://stackoverflow.com/a/6065944/10090036)

#### Pulling from & Pushing to Releases:
  * Pulling Protocols:
    * Every day prior to beginning or continuing work you should be pulling the current _Release_ branch `git pull origin release/<release_number>`.
  * Pushing Protocols:
    * Let's say you've created a new feature branch called `feat/this_new_thing` and now you need to merge it into `release/1.1`. There are a few thing you should do:
      * First: Double check that there are is no leftover code or files that will go unused (i.e. `puts` blocks, quick test routes & associated files.)
      * Second: You should pull the release branch into your feature branch to check for merge conflicts. (Instruction: While in your _Feature_ branch `feat/this_new_thing` you should use the command `git pull origin release/1.1`.)
      * Third: If there were merge conflicts their exact locations will be noted in your terminal. Go to those files and resolve the conflicts. When done with ALL merge conflicts, perform an additional commit to your branched like so `git commit -m "Merged with release/1.1"`.
      * Fourth: TESTS (To be added shortly)
      * Fifth: Now that there are __no more conflicts__ (provided you had any at all) & you have __100% test coverage__ you will now make a pull request in github to the current sprint's release branch.
  * If you have additional questions on version control please contact the CTO (Who is more than happy to help, cause version control sucks!).

#### Our Technologies:
  * [Ruby](https://www.ruby-lang.org/en/) Version: `ruby 2.3.4p301 (2017-03-30 revision 58214) [x86_64-darwin16]`.
  * [Rails](https://rubyonrails.org/) Version: `Rails 5.1.4`.
  * Database(s): [PostgreSQL](https://www.postgresql.org/), [Amazon S3](https://aws.amazon.com/s3/).
  * Notable Ruby Gems:
    * [carrierwave](https://github.com/carrierwaveuploader/carrierwave)
    * [mini_magick](https://github.com/minimagick/minimagick)
    * [dotenv](https://github.com/bkeepers/dotenv)
    * [fog](https://github.com/fog/fog)
    * [twilio-ruby](https://github.com/twilio/twilio-ruby)
    * [stripe](https://github.com/stripe/stripe-ruby)
    * [phony_rails](https://github.com/joost/phony_rails)
    * [activevalidators](https://github.com/franckverrot/activevalidators)
    * [attr_encrypted](https://github.com/attr-encrypted/attr_encrypted)
    * [carmen-rails](https://github.com/carmen-ruby/carmen-rails)
    * [city-state](https://github.com/loureirorg/city-state)
    * [ckeditor](https://github.com/galetahub/ckeditor)
    * [will_paginate](https://github.com/mislav/will_paginate)
#### App Dependencies & API's:
  * [Survey.js](https://surveyjs.io/Overview/Library/)
  * [Prefinery](https://www.prefinery.com/)
  * [Stripe API](https://stripe.com/docs/api)
  * [Twillo API](https://www.twilio.com/docs/api)
  * [Accurate Background API](https://resources.accurate.com/background-check-api)
#### Required Test Suites:
  * [RSpec](https://github.com/BlaineAndersonDev/Rails5_2018_Skeleton#rspec-installation--commands)
  * [SimpleCov](https://github.com/colszowka/simplecov)
  * [FactoryBot](https://github.com/thoughtbot/factory_bot)
  * [CircleCI]()
#### Credited Contributions:
  * [Social Media Icons](https://github.com/bradvin/social-share-urls)

#### CTO/CEO Push to Development/Production Instructions:
  * Upon the start of a new sprint, the old sprint should be merged into the Development branch for a final quality assurance test for a minimum of 72 hours. __All test suites must pass with 100% coverage__.
    * I.E.
      * _Step 1_: It is Monday & Sprint 1 has just been completed (release/1.0). Sprint 2 now has an updated release branch (release/2.0) that all developers now work off of.
      * _Step 2_: Sprint 1 will now be merged into the development branch and __must have 100% test coverage__.
      * _Step 3_: After a minimum of 72 hours the field tested development branch is merged with the master branch.

#### (New) Engineer/Developer Required Technologies:
  * There are some technologies you will need to install and setup prior to working on SenYours. This is a simple guide for your convenience:
    * Environment: You will need to create a local `.env` file in the root directory of the SenYours repository and place our env variables into it. Contact our CTO if you need our environment variables.
    * Message our CTO with your primary email join our ClickUp to keep track of our current Release, tasks and receive assignments.
    * Click to join our [Slack](https://join.slack.com/t/senyours/shared_invite/enQtNDA1OTk1Mjk0NjU3LWZhNzBkM2Q0MDAzZWFhZTNiMzU2M2QyZDI3NmViZjU5YTg4NGFlOGE5MzcwNGZhN2YyMTE3ZWJjOGE4NTY3ZmQ) to stay up to date with announcements & work with your co-developers.
    * Read and follow: [Coders Handbook](https://github.com/BlaineAndersonDev/coders-handbook/blob/master/coder_installation_instructions.md)

## Completed Sprints:
##### Sprint 1 (July 30th - Aug 5th): [Backend Rework]
    * ☑ Implement Testing Technologies (RSpec, SimpleCov).
    * ☑ Controller "available_days" has been reworked with new routes (set_date_unavailable, set_date_available, time_sheet, close_time_sheet) and two additonal routes for use in sprint 2 (set_time_unavailable, set_time_available).
    * ☑ Views in available_days ahve been ajax-ifed (calendar, set_date_available, set_date_unavailable, set_time_available, set_time_unavailable, time_sheet, close_time_sheet).
