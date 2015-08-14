class APIError extends Error
    constructor: (@message) ->
        @name = 'APIError'

class CacheError extends Error
    constructor: (@message) ->
        @name = 'CacheError'

class EmptyCartError extends Error
    constructor: (@message) ->
        @name = 'EmptyCartError'

class GetCartError extends Error
    constructor: (@message) ->
        @name = 'GetCartError'

module.exports.APIError = APIError
module.exports.CacheError = CacheError
module.exports.EmptyCartError = EmptyCartError
module.exports.GetCartError = GetCartError