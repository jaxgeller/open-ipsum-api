[![Build Status](https://travis-ci.org/jaxgeller/open-ipsum-api.svg?branch=master)](https://travis-ci.org/jaxgeller/open-ipsum-api)

# Open Ipsum API

This is the API backing to [openipsum.com](https://openipsum.com). It is built using Rails-api.

## Using the API

The host for the API is `https://api.openipsum.com`, __all requests must be made over https.__

## Endpoints

```
GET    /ipsums      Get all ipsums
POST   /ipsums      Create an ipsum
GET    /ipsums/:id  Get specific ipsum
Put    /ipsums/:id  Update an ipsum
DELETE /ipsums/:id  Delete an ipsum

GET    /search      Search by text and title

POST   /users       Create user
GET    /users/:id   Get a specific user
PUT    /users/:id   Update a user
DELETE /users/:id   Delete a user

POST   /signin      Signs in a user
DELETE /signout     Signs out a user
```

## Contributing

If you find any bugs or would like to ask for features, please open an issue.

Otherwise details for running this application can be found below.

### Prerequisites

You will need the following things properly installed on your computer.

* Ruby 2.2.3
* Rails 4.2.5
* Postgresql

### Installation

* `git clone https://github.com/jaxgeller/open-ipsum-api` this repository
* change into the new directory
* `bundle`
* `rake db:reset`

### Running / Development

* `rails server`
