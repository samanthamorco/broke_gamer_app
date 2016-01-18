(function (){
  "use strict";

  angular.module("app").controller("reviewCtrl", function($scope, $http){

    $scope.setup = function(id) {
      $http.get("/api/v1/reviews.json").then(function(response){
        var data = response.data;
        var reviews = [];
        for(var i = 0; i < data.length; i++) {
          if (id === data[i].product_id){
            reviews.push(data[i]);
          };

        };       

        $scope.reviews = reviews;
      });
    }

    $scope.addReview = function(reviewComments, reviewRating, reviewProductId) {
      if (reviewComments) {
        var reviewInfo = {
          rating: reviewRating,
          comments: reviewComments,
          product_id: reviewProductId,
          date: Date.now(),
          upvotes: 0,
        };
        console.log(reviewInfo);
        $http.post("/api/v1/reviews.json", reviewInfo).then(function(response){
          $scope.reviews.push(reviewInfo);
        }, function(error){
          $scope.errorMessages = error.data.errors;
        });
      }
    }

    $scope.reviewUpvote = function(id, index) {
      var update = {
        upvotes: ($scope.reviews[index].upvotes + 1)
      };
      console.log(update);
      // console.log(update.class);
      $http.patch('/api/v1/reviews/' + id + '.json', update).then(function(response){
        $scope.reviews[id].upvotes.patch(update);
      });
    }

    $scope.reviewDownvote = function(id, index) {
      var update = {
        upvotes: ($scope.reviews[index].upvotes - 1)
      };
      console.log(update);
      // console.log(update.class);
      $http.patch('/api/v1/reviews/' + id + '.json', update).then(function(response){
        $scope.reviews[id].upvotes.patch(update);
      });
    }
    
    window.$scope = $scope;


  });

}());