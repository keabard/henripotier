Promise     = require 'bluebird'
request     = Promise.promisify require('request')

errors      = require './errors'

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
                throw new errors.APIError 'HTTP response error from Xebia API'
            return body
        .then JSON.parse
        .catch SyntaxError, (error) ->
            throw new errors.APIError 'Response from Xebia API is not a JSON'
        .then (body) ->
            return body
        .catch (error) ->
            throw error

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
                throw new errors.APIError 'HTTP response error from Xebia API'
            return body
        .then JSON.parse
        .catch SyntaxError, (error) ->
            throw new errors.APIError 'Response from Xebia API is not a JSON'
        .then (body) ->
            return body.offers
        .catch (error) ->
            throw error

module.exports = new XebiaApiClient()