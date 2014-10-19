'use strict';

viewModule.controller('settagController', ["$scope", '$location','$rootScope', '$http', function($scope, $location, $rootScope, $http) {

    var w = 300,
        h = 300,
        color = d3.scale.category20b();

    var svg = d3.select("#d3container")
        .append("svg")
        .attr("width",w)
        .attr("height",h)
        .style("background","none")

    var g =  svg.append("g")

    g.append("circle")
        .attr("cx",w/2)
        .attr("cy",h/2)
        .attr("r",w/2)
        .attr("fill", "white")
    g.append("text")
        .attr("transform","translate("+(w/2-23)+","+(h/2-10)+")")
        .attr("class","textlabel")
        .text("PICK")
    g.append("text")
        .attr("transform","translate("+(w/2-6)+","+(h/2+10)+")")
        .attr("class","textlabel")
        .text("A")
    g.append("text")
        .attr("transform","translate("+(w/2-35)+","+(h/2+30)+")")
        .attr("class","textlabel")
        .text("COLOR")

    var i = 20,
        d0 = Math.PI,
        radius = w/3,
        data = []

    for(var i=0;i<21;i++){
        data.push({
            x:w/2+radius*Math.sin(i/Math.PI),
            y:h/2+radius*Math.cos(i/Math.PI),
            col:color(i)
            })
        }

    g.selectAll("circle")
        .data(data)
        .enter()
        .append("circle")
        .attr("cx",function(d){ return d.x} )
        .attr("cy",function(d){ return d.y} )
        .attr("fill",function(d){ return d.col} )
        .attr("r",w/7)
        .attr("fill-opacity",0.6)
        .on("mouseover", function(){})
        .on("click", function(d){
            d3.event.stopPropagation();
            console.debug(d.col)
            $location.path("/viewtag")
            postData(d.col, $rootScope.data.selected);
            $scope.$apply()
        })

    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////

    var baseApiUrl = 'http://10.12.74.110/';
    var lon = $rootScope.config.lon;
    var lat = $rootScope.config.lat;



    $http.defaults.headers.post["Content-Type"] = "application/x-www-form-urlencoded";

    function postData(color, tag) {
        $http({
            url: baseApiUrl+'hashtag/'+tag+'/',
            method: "POST",
            data: 'colour='+color+'&lat='+lat+'&lon='+lon
        })
        .then(function(response) {
                // success
            },
            function(response) { // optional
                // failed
            }
        );
    }
}]);