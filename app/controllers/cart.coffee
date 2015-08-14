express         = require 'express'
Promise         = require 'bluebird'
request         = Promise.promisify require('request')
router          = express.Router()

errors          = require '../libs/errors'
LibraryManager  = require '../libs/library_manager'

router.get '/get_offer', (req, res) ->
    # Get cart content
    LibraryManager.getCart()
    .bind {}
    # Get best commercial offer
    .then (cart) ->
        if not cart? or cart.items.length is 0
            throw new errors.EmptyCartError 'Your cart is empty !'
        @cart = cart
        return LibraryManager.getBestCommercialOffer cart
    .then (best_offer) ->
        return res.json best_offer
    .catch errors.EmptyCartError, (error) ->
        return res.json error
    .catch (error) ->
        return res.status(500).json error

router.get '/get', (req, res) ->
    # Get cart
    LibraryManager.getCart()
    .then (cart) ->
        return res.json cart
    .catch errors.GetCartError, (error) ->
        return res.status(500).json error

router.post '/add_item', (req, res) ->
    # Handle item (correct price, isbn, cover, etc...)
    req.checkBody('isbn', 'Tried to add an item to the cart with an empty/invalid isbn').notEmpty().isUUID()
    req.checkBody('title', 'Tried to add an item to the cart with an empty title').notEmpty()
    req.checkBody('cover', 'Tried to add an item to the cart with an empty/invalid cover url').notEmpty().isURL()
    req.checkBody('price', 'Tried to add an item to the cart with an empty/invalid price').notEmpty().isNumeric()
    val_errors = req.validationErrors()
    if val_errors
        return res.json val_errors

    # Add item to cart
    LibraryManager.addItemToCart req.body
    .then (cart) ->
        return res.json cart
    .catch (error) ->
        return res.status(500).json error

router.post '/remove_item', (req, res) ->
    # Handle item (correct price, isbn, cover, etc...)
    req.checkBody('isbn', 'Tried to remove an item from the cart with an empty/invalid isbn').notEmpty().isUUID()
    req.checkBody('title', 'Tried to remove an item from the cart with an empty title').notEmpty()
    req.checkBody('cover', 'Tried to remove an item from the cart with an empty/invalid cover url').notEmpty().isURL()
    req.checkBody('price', 'Tried to remove an item from the cart with an empty/invalid price').notEmpty().isNumeric()
    val_errors = req.validationErrors()
    if val_errors
        return res.json val_errors

    # Remove item from cart
    LibraryManager.removeItemFromCart req.body
    .then (cart) ->
        return res.json cart
    .catch (error) ->
        return res.status(500).json error

module.exports = router