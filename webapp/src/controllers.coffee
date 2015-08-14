'use strict'

AppCtrl = ($scope, cartService) ->
    cartService.getCart()
    $scope.cartService = cartService

angular
    .module('app.controllers', [])
    .controller('AppCtrl', ['$scope', 'cartService', AppCtrl])