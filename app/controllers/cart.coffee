express         = require 'express'
Promise         = require 'bluebird'
request         = Promise.promisify require('request')
router          = express.Router()

LibraryManager  = require '../libs/library_manager'

router.get '/checkout', (req, res) ->
    # Get cart content
    LibraryManager.getCart()
    # Get best commercial offer
    .then (cart) ->
        if not cart?
            return res.render 'cart/cart'
        return LibraryManager.getBestCommercialOffer cart
    .then (best_offer) ->
        return res.render 'cart/cart',
            cart: cart
            best_offer: best_offer
    .catch (error) ->
        return res.json error

router.post '/add_item', (req, res) ->
    # Handle item (correct price, isbn, cover, etc...)

    # Add item to cart
    LibraryManager.addItemToCart req.param('item')
    .then (cart) ->
        return res.json cart
    .catch (error) ->
        return res.json error

module.exports = router