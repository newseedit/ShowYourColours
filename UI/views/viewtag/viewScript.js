'use strict';

viewModule.controller('viewtagController', ["$scope",'$http','$rootScope','selection', function($scope,$http,$rootScope,selection) {
    $rootScope.config = {}
    $scope.spinner = false;
    $scope.selection = selection.selected;

    $http.get('http://10.12.74.110/backend/hashtag').
        success(function(data) {
            $scope.tags = data.hashtag;
        });

    $scope.select = function(){
        var path = 'http://10.12.74.110/backend/hashtag/'+$scope.selection

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