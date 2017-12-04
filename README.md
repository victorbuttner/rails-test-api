# Rails API with authentication and integration tests with Rspec

## Gem include:

rspec => testing
chartkick => dashboard
bootstrap-sass, '~> 3.3.7' => some style

## Calling the API

curl -H "Authorization: Token token=dd9fe46f6953663aa2742fa008bf0463" http://localhost:3000/questions

curl -H "Authorization: Token token=dd9fe46f6953663aa2742fa008bf0463" http://localhost:3000/questions?title=keytar

curl -H "Authorization: Token token=dd9fe46f6953663aa2742fa008bf0463" http://localhost:3000/questions/:id

## Running tests:
bundle exec rspec


## TODO:
throttle configuration with gem rack-attack 

## Project Setup

Clone this repo locally, and from the top-level directory run:

`bundle install`

`bundle exec rake db:setup`

To make sure it's all working,

`rails s`
