express     = require 'express'
Promise     = require 'bluebird'
request     = Promise.promisify require('request')
router      = express.Router()

router.post '/checkout', (req, res) ->
    # Handle items argument
    if not req.param('items')?
        return res.redirect '/'
    else if req.param('items').length is 0
        return res.redirect '/'

    # Build API request url, and get best commercial offer from API response
    items_string = req.param('items').join ','
    request
        uri: "http://henri-potier.xebia.fr/books/#{items_string}/commercialOffers"
        method: 'GET'
        json: true
    .spread (response, body) ->
        for offer in body.offers

        return res.json 'OK'

module.exports = router