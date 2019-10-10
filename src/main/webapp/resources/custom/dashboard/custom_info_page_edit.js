app.controller('InfoPageEditController', function($http, $scope, $filter, $rootScope, $mdToast, $mdDialog, $window, $location, $cookies, Page) {
	Page.setTitle('Chỉnh sửa thông tin trang');

	var last = {
		bottom: false,
		top: true,
		left: false,
		right: true
	};

	$scope.toastPosition = angular.extend({}, last);

	$scope.getToastPosition = function() {
		sanitizePosition();

		return Object.keys($scope.toastPosition)
		.filter(function(pos) { return $scope.toastPosition[pos]; })
		.join(' ');
	};

	function sanitizePosition() {
		var current = $scope.toastPosition;

		if (current.bottom && last.top) current.top = false;
		if (current.top && last.bottom) current.bottom = false;
		if (current.right && last.left) current.left = false;
		if (current.left && last.right) current.right = false;

		last = angular.extend({}, current);
	}
	
	$scope.showSimpleToast = function(text) {
		var pinTo = $scope.getToastPosition();

		$mdToast.show(
			$mdToast.simple()
			.textContent(text)
			.position(pinTo)
			.hideDelay(3000)
		);
	};

	$http.post('/FlowerShop/api/get_du_lieu_trang_chu', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		var duLieuTrangChu = response.data;
		if (duLieuTrangChu != undefined) {
			var thongTinField = $filter('filter')(duLieuTrangChu, {tenTruong: 'thongTin'})[0].noiDung;
			if (thongTinField != undefined) {
				$scope.thongTinTrangWeb = thongTinField;
			}
		}
	}, function(error) {
		console.log(error);
	});

	$scope.chinhSuaThongTin = function(thongTinTrangWeb) {
		$http.post('/FlowerShop/api/cap_nhat_trang_chu', angular.toJson({
			thongTin: thongTinTrangWeb
		}), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			$scope.showSimpleToast(response.data.notice);
		}, function(error) {
			console.log(error);
		});
	}
});