express         = require 'express'
Promise         = require 'bluebird'
request         = Promise.promisify require('request')
router          = express.Router()

LibraryManager  = require '../libs/library_manager'

router.get '/', (req, res) ->
    LibraryManager.getBooks()
    .then (books) ->
        return res.render 'shop/shop',
            books: books

router.get '/books', (req, res) ->
    LibraryManager.getBooks()
    .then (books) ->
        return res.json books

module.exports = router