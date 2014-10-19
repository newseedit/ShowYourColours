'use strict';

viewModule.controller('viewtagController', ["$scope",'$http','$rootScope','selection', function($scope,$http,$rootScope,selection) {
    $rootScope.config = {}
    $scope.spinner = false;
    $scope.selection = selection.selected;

    $http.get(selection.baseURL + '/backend/hashtag').
        success(function(data) {
            $scope.tags = data.hashtag;
        });

    $scope.select = function(){
        var path = selection.baseURL + '/backend/hashtag/'+$scope.selection

        $scope.spinner = true
        $rootScope.config.purge = true


        $http.get(path).
            success(function(response) {
                 $rootScope.data = response.hashtag.data;
                 $rootScope.data.selected = $scope.selection;
                 $scope.spinner = false
                 selection.selected = $scope.selection
            });
    }
}]);