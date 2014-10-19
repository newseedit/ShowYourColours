'use strict';

viewModule.controller('indexController', ["$scope","$rootScope",'jsonService','$http','$location', 'selection',
    function($scope,$rootScope, jsonService,$http, $location, selection) {
    $rootScope.config = {}
    $scope.spinner = false;
    $scope.tags = []
    $scope.selected = selection.selected

    $http.get(selection.baseURL + '/backend/hashtag').
        success(function(data) {
            $scope.tags = data.hashtag;
        });

    $scope.select = function(){
        var path = selection.baseURL + '/backend/hashtag/'+$scope.selected
        $rootScope.config.purge = true

        $scope.spinner = true
        $http.get(path).
            success(function(response) {
                 $rootScope.data = response.hashtag.data;
                 //$rootScope.data.selected = $scope.selected;
                 selection.selected = $scope.selected
                 $scope.spinner = false;
                 $location.path("/viewtag")
            });
    }

    $http.get(selection.baseURL + '/backend/colour/').
        success(function(response) {
            $rootScope.data = response.colour.data;
            selection.selected = ""
    });

    /////////////////////////////////////////////////////////////////

    function getLocation() {
        if (navigator.geolocation) {
            console.debug("nav")
            navigator.geolocation.getCurrentPosition(setPosition);
        }
    }

    function setPosition(pos){

        $rootScope.config.lat = pos.coords.latitude;
        $rootScope.config.lon = pos.coords.longitude;

        selection.lon = pos.coords.longitude;
        selection.lat = pos.coords.latitude;
        console.debug("###########")
        console.debug($rootScope.config.lat)
        console.debug($rootScope.config.lon)
    }
    getLocation()
}]);