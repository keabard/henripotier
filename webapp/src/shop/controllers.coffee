ShopCtrl = ($scope) ->

BooksListCtrl = ($scope, $http, cartService) ->
    $http.get '/books'
    .then (response) ->
        $scope.books = response.data
    , (error) ->
        console.log 'Error'

   	$scope.addBookToCart = (book) ->
        return cartService.addItemToCart book

    $scope.removeBookFromCart = (book) ->
        return cartService.removeItemFromCart book

    $scope.isBookInCart = (book) ->
        return cartService.isItemInCart book

angular
    .module('shop.controllers', [])
    .controller('ShopCtrl', ['$scope', ShopCtrl])
    .controller('BooksListCtrl', ['$scope', '$http', 'cartService', BooksListCtrl])