(function (){
  "use strict";

  angular.module("app").controller("wishlistCtrl", function($scope, $http){

    $scope.setup = function() {
      $http.get("/api/v1/wishlist.json").then(function(response){
        $scope.wishlists = response.data
      });
    }

    $scope.deleteGame = function(id) {
      // $scope.wishlists.splice(index, 1)
      console.log(id);
      $http.delete('/api/v1/wishlist/' + id + '.json', id).then(function(response) {
        var wishlistCallback = response.data;
        console.log(wishlistCallback);
        console.log("happy path!");
      });
    }

    $scope.sortableOptions = {
      disabled: false,
      update: function(event) {
        $scope.test();
      }
    };

    $scope.test = function() {
      var wishlist = $scope.wishlists
      for (var i = 0; i <= 3; i++) {
        console.log(wishlist[i].priority);
      };
        console.log("");
    };

    // $scope.changePriority = function(index, priority) {
    //   console.log(index);
    //   console.log(priority);
    //   }
    // }

    window.$scope = $scope;
  });

}());