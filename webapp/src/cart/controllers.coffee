CartCtrl = ($scope) ->

CartCheckoutCtrl = ($scope, $http) ->
    
    # Get offer from server
    getOffer = () ->
        $http.get '/cart/get_offer'
        .then (response) ->
            $scope.best_offer = response.data
        , (response) ->
            console.error 'Error while getting best commercial offer : ' + response.data.message

    $scope.$watch 'cartService.cart.items', (newValue, oldValue) ->
        getOffer()

angular
    .module('cart.controllers', [])
    .controller('CartCtrl', ['$scope', CartCtrl])
    .controller('CartCheckoutCtrl', ['$scope', '$http', CartCheckoutCtrl])