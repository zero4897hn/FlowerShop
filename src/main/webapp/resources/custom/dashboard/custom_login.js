'use strict';
var app = angular.module('myApp', ['ngMaterial', 'ngCookies']);
app.controller('MyController',  function($scope, $http, $cookies, $window) {
	var idNhanVienHienTai = $cookies.get('id_nhan_vien_hien_tai');

	if (idNhanVienHienTai != undefined) {
		$http.post('/FlowerShop/api/get_nhan_vien', angular.toJson({
			idNhanVien: idNhanVienHienTai
		}), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			var nhanVien = response.data;
			if (nhanVien.chucVu.id > 1) {
				if ($window.history.length < 3) {
					$window.location.href = '/FlowerShop/admin';
				}
				else {
					$window.history.back();
				}
			} else {
				$scope.notification = 'Bạn không thể đăng nhập trang quản trị với tư cách là khách hàng.';
			}
		}, function(error) {
			console.log(error);
		});
	}

	$scope.dangNhapTaiKhoan = function(item) {
		$scope.notification = undefined;

		$http.post('/FlowerShop/api/dang_nhap_quan_tri', angular.toJson(item), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			var notification = response.data.notice;
			if (notification == 'success') {
				if (item.ghiNhoDangNhap == undefined) item.ghiNhoDangNhap = false;
				if (item.ghiNhoDangNhap) {
					var date = new Date();
					var jsonOption = {
						expires: new Date(date.getTime() + 25920000000),
						path: '/FlowerShop'
					}
				}
				else {
					var jsonOption = {
						path: '/FlowerShop'
					}
				}
				$cookies.put('id_nhan_vien_hien_tai', response.data.idNhanVien, jsonOption);
				$window.location.href = '/FlowerShop/admin';
			}
			else {
				$scope.notification = notification;
			}
		}, function(error) {
			console.log(error);
		});
	}
});