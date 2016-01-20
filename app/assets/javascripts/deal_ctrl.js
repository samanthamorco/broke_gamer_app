(function (){
  "use strict";

  angular.module("app").controller("dealCtrl", function($scope, $http){

    $scope.setup = function() {
      $http.get("/api/v1/deals.json").then(function(response){
        var data = response.data;
        var deals = [];
        for(var i = 0; i < data.length; i++) {
          if (data[i].status === "pending"){
            deals.push(data[i]);
          };
        };       
        $scope.deals = deals;
      });
    }

    $scope.testDeals = function() {
      alert("Test success!");
    }

  $scope.statuses = [
    {value: 'pending', text: 'pending'},
    {value: 'active', text: 'active'},
    {value: 'inactive', text: 'inactive'},
  ];

    $scope.updateDeals = function() {
      var deal = $scope.deals;
      console.log("Hello!");
      for (var i = 0; i < $scope.deals.length; i++) {
        var update = {
          product_id: deal[i].product_id,
          price: deal[i].price,
          url: deal[i].url,
          comment: deal[i].comment,
          status: deal[i].status,
        };
          console.log("the following should be the variable update:")
          console.log(update);
          $http.patch('/api/v1/deals/' + deal[i].id + '.json', update).then(function(response){
          });
      };
      alert("Changes Saved");
    }

    window.$scope = $scope;


  });

}());