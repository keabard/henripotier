'use strict'

angular
    .module('app', ['ngRoute', 'app.controllers', 'app.services', 'shop'])
    .config(['$locationProvider', ($locationProvider) ->
    	#$locationProvider.html5Mode true
    ])