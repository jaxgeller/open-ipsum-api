[![Build Status](https://travis-ci.org/jaxgeller/open-ipsum-api.svg?branch=master)](https://travis-ci.org/jaxgeller/open-ipsum-api)

clone then run

+ `bundle`

+ `docker run --name openipsumdb -e POSTGRES_PASSWORD=openipsum -d postgres`

+ `rake db:setup`

+ `rails s`

+ `curl localhost:3000/ipsums`

### API

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
