'use strict'

angular
    .module('shop', ['ngRoute', 'shop.controllers'])
    .config(['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
            $routeProvider.when '/',
                templateUrl: '/partials/shop/books-list.html',
                controller: 'BooksListCtrl'

            $routeProvider.otherwise
                redirectTo: '/'

            $locationProvider.html5Mode true
    ])