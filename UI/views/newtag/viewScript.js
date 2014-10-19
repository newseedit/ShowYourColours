'use strict';

viewModule.controller('newtagController', ["$scope", "$location", function($scope, $location) {
    $scope.test = "newtagController";

    $scope.update = function(tag){
        console.debug(tag)
        $location.path("/viewtag")
    }
}]);