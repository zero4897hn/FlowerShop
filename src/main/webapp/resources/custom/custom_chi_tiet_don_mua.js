app.controller('ChiTietDonMuaController', function($http, $scope, $rootScope, $routeParams, $mdToast, $mdDialog, $location, $cookies, $window, $filter) {
	var idHoaDon = $routeParams.idHoaDon;

	$http.post('/FlowerShop/api/get_hoa_don', angular.toJson({
		idHoaDon: +idHoaDon
	}), {
		headers: {
			'content-type': 'application/json;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.hoaDon = response.data;
		if ($scope.hoaDon != 'null') {
			$scope.hoaDon.ngayLapDate = new Date($scope.hoaDon.ngayLap);
		}
	}, function(error) {
		console.log(error);
	});

	$scope.getGiaKhuyenMai = function(kieuSanPham) {
		if ($scope.hoaDon != undefined) {
			var dsKhuyenMai = $filter('filter')(kieuSanPham.danhSachKhuyenMai, function(khuyenMai) {
				return (!khuyenMai.daXoa && $scope.hoaDon.ngayLap > khuyenMai.thoiGianBatDau && $scope.hoaDon.ngayLap < khuyenMai.thoiGianKetThuc)
			});
			var giaKhuyenMai = kieuSanPham.giaTien;
			dsKhuyenMai.forEach(function(value) {
				var phanTramGiam = value.phanTramGiam / 100;
				var giaTienSauKhiGiamToiDa = giaKhuyenMai - value.giaGiamToiDa;
				giaKhuyenMai = giaKhuyenMai * (1 - phanTramGiam);
				if (giaKhuyenMai < giaTienSauKhiGiamToiDa) giaKhuyenMai = giaTienSauKhiGiamToiDa;
			});
			return giaKhuyenMai;
		}
		return 0;
	}

	$scope.tongTien = function() {
		if ($scope.hoaDon != undefined) {
			var sum = 0;
			$scope.hoaDon.danhSachDonHang.forEach(function(value) {
				sum = sum + ($scope.getGiaKhuyenMai(value.kieuSanPham) * value.soLuong);
			});
			return sum;
		}
		return 0;
	}
});