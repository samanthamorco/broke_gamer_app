(function (){
  "use strict";

  angular.module("app").controller("reviewCtrl", function($scope, $http){

    $scope.setup = function() {
      $http.get("/api/v1/reviews.json").then(function(response){
        $scope.reviews = response.data;
        console.log(response.data)
      });
    }

    $scope.addReview = function(reviewComments, reviewRating) {
      if (reviewComments) {
        var reviewInfo = {
          rating: reviewRating,
          comments: reviewComments,
        };
        console.log(reviewInfo)
        $http.post("/api/v1/reviews.json", reviewInfo).then(function(response){
          $scope.reviews.push(reviewInfo);
        }, function(error){
          $scope.errorMessages = error.data.errors;
        });
      }
    }




  });

}());