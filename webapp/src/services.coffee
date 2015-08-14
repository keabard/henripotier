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
                , (response) ->
                    console.error 'Error while adding an item to the cart : ' + response.data.message

            removeItemFromCart: (item) ->
                $http.post '/cart/remove_item', item
                .then (response) =>
                    @cart = response.data
                , (response) ->
                    console.error 'Error while removing an item from the cart : ' + response.data.message

            getCart: () ->
                $http.get '/cart/get'
                .then (response) =>
                    @cart = response.data
                , (response) ->
                    console.error 'Error while getting the cart : ' + response.data.message
    ]               