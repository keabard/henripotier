express         = require 'express'
Promise         = require 'bluebird'
request         = Promise.promisify require('request')
router          = express.Router()

errors          = require '../libs/errors'
LibraryManager  = require '../libs/library_manager'

router.get '/checkout', (req, res) ->
    # Get cart content
    LibraryManager.getCart()
    .bind {}
    # Get best commercial offer
    .then (cart) ->
        if not cart?
            throw new errors.CartError 'Your cart is empty !'
        @cart = cart
        return LibraryManager.getBestCommercialOffer cart
    .then (best_offer) ->
        console.log 'BEST OFFER', best_offer
        return res.render 'cart/cart',
            cart: @cart
            best_offer: best_offer
    .catch errors.CartError, (error) ->
        return res.render 'cart/cart'

router.post '/add_item', (req, res) ->
    # Handle item (correct price, isbn, cover, etc...)

    # Add item to cart
    LibraryManager.addItemToCart req.body
    .then (cart) ->
        console.log cart.items.length
        return res.json cart
    .catch (error) ->
        return res.json error

router.post '/remove_item', (req, res) ->
    # Remove item from cart
    LibraryManager.removeItemFromCart req.body
    .then (cart) ->
        console.log cart.items.length
        return res.json cart
    .catch (error) ->
        console.log 'error', error
        return res.json error    

module.exports = router