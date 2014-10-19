'use strict';

// Declare app level module which depends on views, and components
angular.module('myApp', [
        'ngRoute',
        'ui.bootstrap',
        'myApp.views',
        'myApp.services',
        'myApp.directives',
        'myApp.version'
    ])
    .controller('test', ['$rootScope', function($rootScope){
             //$rootScope.data = {};
            //$scope.data = jsonService.getWorldJSON();
        }])
    .config(['$routeProvider', function($routeProvider) {
        $routeProvider.otherwise({redirectTo: '/index'});
    }])

