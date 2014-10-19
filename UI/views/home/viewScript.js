'use strict';

viewModule.controller('indexController', ["$scope","$rootScope",'jsonService','$http','$location',
    function($scope,$rootScope, jsonService,$http, $location) {

    $scope.spinner = false;
    $scope.tags = []
    $scope.selected = ""

    $http.get('http://10.12.74.110/backend/hashtag/').
        success(function(data) {
            $scope.tags = data.hashtag;
            console.debug($scope.tags)
        });

    $scope.select = function(){
        var path = 'http://10.12.74.110/backend/hashtag/'+$scope.selected
        $rootScope.data = "purge"
        $scope.spinner = true
        $http.get(path).
            success(function(response) {
                 $rootScope.data = response.hashtag.data;
                 $rootScope.data.selected = $scope.selected;
                 $scope.spinner = false;
                 $location.path("/viewtag")
            });
    }

    /////////////////////////////////////////////////////////////////

    function getLocation() {
        if (navigator.geolocation) {
            console.debug("nav")
            navigator.geolocation.getCurrentPosition(setPosition);
        }
    }

    function setPosition(pos){
        $rootScope.config = {}
        $rootScope.config.lat = pos.coords.latitude;
        $rootScope.config.lon = pos.coords.longitude;
        console.debug("###########")
        console.debug($rootScope.config.lat)
        console.debug($rootScope.config.lon)
    }
    getLocation()
}]);