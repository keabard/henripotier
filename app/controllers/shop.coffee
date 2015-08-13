express         = require 'express'
Promise         = require 'bluebird'
request         = Promise.promisify require('request')
router          = express.Router()

LibraryManager  = require '../libs/library_manager'

router.get '/', (req, res) ->
    return res.render 'shop/shop'

router.get '/books', (req, res) ->
    LibraryManager.getBooks()
    .then (books) ->
        return res.json books

module.exports = router