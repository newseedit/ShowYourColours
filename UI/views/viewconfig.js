var viewModule = angular.module('myApp.views', ['ngRoute'])
    .config(['$routeProvider', function($routeProvider) {
        $routeProvider.when('/index', {
            templateUrl: 'views/home/homeView.html',
            controller: 'indexController'
        });

        $routeProvider.when('/viewtag', {
            templateUrl: 'views/viewtag/viewtagView.html',
            controller: 'viewtagController'
        });

        $routeProvider.when('/settag', {
            templateUrl: 'views/settag/settagView.html',
            controller: 'settagController'
        });

        $routeProvider.when('/newtag', {
            templateUrl: 'views/newtag/newtagView.html',
            controller: 'newtagController'
        });
    }])