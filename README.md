# Please Pack

---
## Dependencies
- Postgres
- Ruby 2.3.1
- Bundler
- yarn
- chromedriver (for integration tests)

## Installation

Assuming dependencies are installed and Postgres is running:

```
git clone git@github.com:mattduboismatt/please-pack.git
cd please-pack
bundle install
rails db:create db:migrate db:seed
rake
yarn
bundle exec rails server
yarn start
```


## Development
Run the development server:

```
bundle exec rails server
yarn start
```

## Testing
Run all the tests:

```
rake
```