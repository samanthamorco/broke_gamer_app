(function (){
  "use strict";

  angular.module("app").controller("wishlistCtrl", function($scope, $http){

    $scope.setup = function() {
      $http.get("/api/v1/wishes.json").then(function(response){
        $scope.wishes = response.data
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
      var wish = $scope.wishes
      for (var i = 1; i <= $scope.wishes.length; i++) {
        if (i !== wish[i - 1].priority) {
          var update = {
            priority: i
          };
          console.log("the following should be the variable update:")
          console.log(update);
          $http.patch('/api/v1/wishes/' + wish[i - 1].id + '.json', update).then(function(response){
            // var wishlistCallback = response.data;
            // console.log(response.data);
            // $scope.wishes.patch(wishlistCallback);

            // console.log(test);
          });
        }
      };
      alert("Changes Saved");
    }

    $scope.deleteGame = function(id, index) {
      $scope.wishes.splice(index, 1);
      $http.delete('/api/v1/wishes/' + id + '.json').then(function(response){
        var wishlistCallback = response.data;
        console.log(response.data);
        $scope.wishes.push(wishlistCallback);
      });
    }
    


    window.$scope = $scope;
  });

}());