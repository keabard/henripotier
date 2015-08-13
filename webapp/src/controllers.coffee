'use strict'

AppCtrl = ($scope, cartService) ->
    $scope.cartService = cartService

angular
    .module('app.controllers', [])
    .controller('AppCtrl', ['$scope', 'cartService', AppCtrl])