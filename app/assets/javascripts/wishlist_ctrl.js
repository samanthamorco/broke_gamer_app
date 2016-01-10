(function (){
  "use strict";

  angular.module("app").controller("wishlistCtrl", function($scope, $http){

    $scope.setup = function() {
      $http.get("/api/v1/wishlist.json").then(function(response){
        $scope.wishlists = response.data
      });
    }


  });

}());