'use strict';

viewModule.controller('viewtagController', ["$scope",'$http','$rootScope', function($scope,$http,$rootScope) {

    $scope.spinner = false;

    $http.get('http://10.12.74.110/backend/hashtag').
        success(function(data) {
            $scope.tags = data.hashtag;
        });

    $scope.select = function(){
        var path = 'http://10.12.74.110/backend/hashtag/'+$scope.selected

        $scope.spinner = true
        $rootScope.data = "purge"
        $http.get(path).
            success(function(response) {
                 $rootScope.data = response.hashtag.data;
                 $rootScope.data.selected = $scope.selected;
                 $scope.spinner = false
            });
    }
}]);