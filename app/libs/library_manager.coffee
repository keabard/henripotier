_               = require 'lodash'
NodeCache       = require 'node-cache'
Promise         = require 'bluebird'
request         = Promise.promisify require('request')

errors          = './errors'
XebiaApiClient  = require './xebia_api_client'

class LibraryManager

    constructor: () ->
        @cache = new NodeCache()
        @cache.get = Promise.promisify @cache.get
        @cache.set = Promise.promisify @cache.set

    ###*
    * Gets cart content
    * @return {Promise} cart
    *###
    getCart: () ->
        @cache.get 'cart'
        .then (value) ->
            return value

    ###*
    * Adds an item to the cart
    * @parameter {Object} item
    * @return {Promise} cart
    *###
    addItemToCart: (item) ->
        @cache.get 'cart'
        .then (cart) =>
            if not cart?
                cart =
                    items: [item]
                    total_price: item.price
            else
                cart.items.push item
                cart.total_price += item.price
            @cache.set 'cart', cart, 60
            .return cart

    ###*
    * Removes an item from the cart
    * @parameter {Object} item
    * @return {Promise} cart
    *###
    removeItemFromCart: (item) ->
        @cache.get 'cart'
        .then (cart) =>
            if not cart?
                throw new errors.CacheError 'No cart in cache while attempting to remove an item'
            else
                for index, cart_item of cart.items
                    if cart_item.isbn is item.isbn
                        cart.items.splice index, 1
                cart.total_price -= item.price
            @cache.set 'cart', cart, 60
            .return cart

    ###*
    * Gets books list, caches it if necessary, and returns it
    * @return {Promise} books
    *###
    getBooks: () ->
        @cache.get 'books'
        .then (value) =>
            if not value?
                return XebiaApiClient.getBooks()
                    .then (books) =>
                        @cache.set 'books', books, 1
                        .return books
            return value

    ###*
    * Returns best commercial offer for a given list of books
    * @param {Object} cart 
    * @return {Promise} best_offer
    *###
    getBestCommercialOffer: (cart) ->
        # Get available offers for this cart
        XebiaApiClient.getCommercialOffers cart.items 
        .then (offers) ->
            best_offer_price = cart.total_price
            for offer in offers
                offer_price = null
                switch offer.type
                    when 'percentage'
                        offer_price = cart.total_price - Math.round(cart.total_price * offer.value / 100.0)
                    when 'minus'
                        offer_price = cart.total_price - offer.value
                    when 'slice'
                        number_of_slice = parseInt cart.total_price / offer.sliceValue
                        offer_price = cart.total_price - number_of_slice * offer.value
                if offer_price < best_offer_price
                    best_offer = offer
                    best_offer_price = offer_price
            return best_offer 

module.exports = new LibraryManager()