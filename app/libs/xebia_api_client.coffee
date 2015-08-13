Promise     = require 'bluebird'
request     = Promise.promisify require('request')

class XebiaApiClient

    ###*
    * Retrieve books list
    * @return {Promise} books
    *###
    getBooks: () ->
        return request
            uri: 'http://henri-potier.xebia.fr/books'
            method: 'GET'
        .spread (response, body) ->
            if response.statusCode isnt 200
                throw new errors.APIError 'HTTP response error'
            return body
        .then JSON.parse
        .catch SyntaxError, (e) ->
            throw new errors.APIError 'Response is not a JSON'
        .then (body) ->
            return body

    ###*
    * Retrieve commercial offers
    * @param {Array} books 
    * @return {Promise} offers
    *###
    getCommercialOffers: (books) ->
        isbn_string = (book.isbn for book in books).join ','
        request
            uri: "http://henri-potier.xebia.fr/books/#{isbn_string}/commercialOffers"
            method: 'GET'
        .spread (response, body) ->
            if response.statusCode isnt 200
                throw new errors.APIError 'HTTP response error'
            return body
        .then JSON.parse
        .catch SyntaxError, (e) ->
            throw new errors.APIError 'Response is not a JSON'
        .then (body) ->
            return body.offers

module.exports = new XebiaApiClient()