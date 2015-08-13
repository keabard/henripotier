class APIError extends Error
    constructor: (@message) ->
        @name = 'APIError'

class CacheError extends Error
    constructor: (@message) ->
        @name = 'CacheError'

class CartError extends Error
	constructor: (@message) ->
        @name = 'CartError'

module.exports.APIError = APIError
module.exports.CacheError = CacheError
module.exports.CartError = CartError