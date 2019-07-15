'use strict';
var app = angular.module('myApp', ['ngMaterial', 'ngCookies']);
app.controller('MyController', function($scope, $http, $cookies, $window, $mdToast, $mdDialog) {
	var idNhanVienHienTai = $cookies.get('id_nhan_vien_hien_tai');
	if (idNhanVienHienTai != undefined) {
		if ($window.history.length < 3) {
			$window.location.href = '/FlowerShop';
		}
		else {
			$window.history.back();
		}
	}

	var last = {
		bottom: false,
		top: true,
		left: false,
		right: true
	};

	$scope.toastPosition = angular.extend({},last);

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

		last = angular.extend({},current);
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

	$scope.dangKy = {};
	$scope.dangKy.gioiTinh = true;

	$scope.isDangKy = false;

	$scope.chuyenTrangThai = function() {
		$scope.isDangKy = !$scope.isDangKy;
	}

	$scope.dangNhapTaiKhoan = function(item) {
		$scope.notification = undefined;

		$http.post('/FlowerShop/api/dang_nhap_tai_khoan', angular.toJson(item), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			var notification = response.data.notice;
			if (notification == 'success') {
				$cookies.put('id_nhan_vien_hien_tai', response.data.idNhanVien, {
					expires: new Date().addDays(300),
					path: '/FlowerShop'
				});
				if ($window.history.length < 3) {
					$window.location.href = '/FlowerShop';
				}
				else {
					$window.history.back();
				}
			}
			else {
				$scope.notification = notification;
			}
		}, function(error) {
			console.log(error);
		});
	}

	Date.prototype.addDays = function(days) {
		var date = new Date(this.valueOf());
		date.setDate(date.getDate() + days);
		return date;
	}


	$scope.dangKyTaiKhoan = function(item) {
		$http.post('/FlowerShop/api/them_nhan_vien', angular.toJson(item), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			var notification = response.data.notice;
			if (notification == 'success') {
				var confirm = $mdDialog.confirm()
					.title('Thông báo')
					.textContent('Đăng ký thành công.')
					.ok('Đăng nhập')
					.cancel('Trở về trang chủ');

				$mdDialog.show(confirm).then(function() {
					$scope.isDangKy = false;
				}, function() {
					$window.location.href = '/FlowerShop'
				});
			}
			else {
				$scope.showSimpleToast(notification);
			}
		}, function(error) {
			console.log(error);
		});
	}
});
app.controller('ToastCtrl', function($scope, $mdToast) {
	$scope.closeToast = function() {
		$mdToast.hide();
	};
});