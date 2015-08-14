'use strict'

angular
    .module('cart', ['cart.controllers'])
    .config(['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
            $routeProvider.when '/checkout',
                templateUrl: '/partials/cart/checkout.html',
                controller: 'CartCheckoutCtrl'

            $routeProvider.otherwise
                redirectTo: '/checkout'
    ])