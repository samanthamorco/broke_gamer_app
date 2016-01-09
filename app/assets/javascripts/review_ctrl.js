(function (){
  "use strict";

  angular.module("app").controller("reviewCtrl", function($scope, $http){

    $scope.setup = function() {
      $http.get("/api/v1/reviews.json").then(function(response){
        $scope.reviews = response.data
      });
    }

    $scope.addReview = function(reviewComments, reviewRating, reviewProductId) {
      if (reviewComments) {
        var reviewInfo = {
          rating: reviewRating,
          comments: reviewComments,
          product_id: reviewProductId,
        };
        console.log(reviewInfo)
        $http.post('/api/v1/reviews.json', reviewInfo).then(function(response){
          var reviewCallback = response.data;
          console.log = reviewCallback;
          console.log("happy path!");
          $scope.people.push(reviewCallback);
        }, function(error){
          console.log("sad path :(");
          $scope.errorMessages = error.data.errors
        });
      }
    }




  });

}());