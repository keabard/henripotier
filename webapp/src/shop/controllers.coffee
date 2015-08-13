ShopCtrl = ($scope) ->

BooksListCtrl = ($scope, $http) ->
    $http.get '/shop/books'
    .then (response) ->
        $scope.books = response.data
    , (error) ->
        console.log 'Error'

angular
    .module('shop.controllers', [])
    .controller('ShopCtrl', ['$scope', ShopCtrl])
    .controller('BooksListCtrl', ['$scope', '$http', BooksListCtrl])