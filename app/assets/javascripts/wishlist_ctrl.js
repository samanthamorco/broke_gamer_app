(function (){
  "use strict";

  angular.module("app").controller("wishlistCtrl", function($scope, $http){

    $scope.setup = function() {
      $http.get("/api/v1/wishlist.json").then(function(response){
        $scope.wishlists = response.data
      });
    }

    $scope.sortableOptions = {
      disabled: false,
      update: function(event) {
        $scope.test();
      }
    };

    $scope.test = function() {
      console.log("cool");
    };

    $scope.updatePriority = function () {
      console.log($scope.wishlists);
      var wishlist = $scope.wishlists
      for (var i = 1; i <= $scope.wishlists.length; i++) {
        if (i !== wishlist[i - 1].priority) {
          var update = {
            priority: i
          };
          console.log("the following should be the variable update:")
          console.log(update);
          $http.patch('/api/v1/wishlist/' + wishlist[i - 1].id + '.json', update).then(function(response){
            // var wishlistCallback = response.data;
            // console.log(response.data);
            // $scope.wishlists.patch(wishlistCallback);

            // console.log(test);
          });
        }
      };
      alert("Changes Saved");
    }

    


    window.$scope = $scope;
  });

}());