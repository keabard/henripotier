ShopCtrl = ($scope) ->

BooksListCtrl = ($scope, $http, cartService) ->
    $http.get '/books'
    .then (response) ->
        $scope.books = response.data
    , (response) ->
    	console.error 'Error while gettings books : ' + response.data.message

   	$scope.addBookToCart = (book) ->
        return cartService.addItemToCart book

angular
    .module('shop.controllers', [])
    .controller('ShopCtrl', ['$scope', ShopCtrl])
    .controller('BooksListCtrl', ['$scope', '$http', 'cartService', BooksListCtrl])