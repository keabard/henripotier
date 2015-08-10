express     = require 'express'
Promise     = require 'bluebird'
request     = Promise.promisify require('request')
router      = express.Router()

router.get '/', (req, res) ->
    request
        uri: 'http://henri-potier.xebia.fr/books'
        method: 'GET'
        json: true
    .spread (response, body) ->
        return res.render 'shop/shop',
            books: body 

module.exports = router