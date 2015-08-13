'use strict'

angular
    .module 'app.services', []
    .factory 'cartService', ['$http', ($http) ->
        new class CartService

            constructor: ->
              @cart = {}

            addItemToCart: (item) ->
                $http.post '/cart/add_item', item
                .then (response) =>
                    @cart = response.data
                , (error) =>
                    console.log 'Add item to cart error'

            removeItemFromCart: (item) ->
                $http.post '/cart/remove_item', item
                .then (response) =>
                    @cart = response.data
                , (error) =>
                    console.log 'Remove item to cart error'

            isItemInCart: (item) ->
                return @cart?.items?.filter((cart_item) -> cart_item.isbn is item.isbn).length > 0
    ]