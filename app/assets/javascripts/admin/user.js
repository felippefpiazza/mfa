angular.module('Mfa', ['ngAnimate'])
	.controller('MfaController', ['$scope', '$http', '$timeout', function($scope, $http, $timeout) {
		
		$scope.login = function() {
			$http.post("/api/auth.json", {username:$scope.Username, password:$scope.Password, mfa_type:$scope.MfaType })
    			.success(function(response) {
					$scope.auth = response;
				});			
		};

		$scope.login_token = function() {
			$http.post("/api/auth_token.json", {username:$scope.Username, access_token:$scope.Token, mfa_type:$scope.MfaType })
    			.success(function(response) {
					$scope.auth_token = response;
				});			
		};		
	}]);