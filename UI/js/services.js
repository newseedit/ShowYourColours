angular.module('myApp.services', [])
    .service('jsonService', ['$http',function($http){

        var tags;

        httpGetTags = function() {
            $http.get('http://10.12.74.110/hashtag').
                success(function(data) {
                    console.debug(data)
                    $scope.tags = data;
                });


        }

        this.getTags = function(){
            httpGetTags()
        }


    }])
    .factory('selection', function(){
        return {
            selected: "",
            baseURL: "http://10.12.74.110"
        }
    })