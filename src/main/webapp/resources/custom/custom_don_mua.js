app.controller('DonMuaController', function($http, $scope, $rootScope, $mdToast, $mdDialog, $location, $cookies, $window, $filter) {
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

	$scope.loginRequire = false;
	$scope.tinhTrangHoaDon = ['Mới đặt', 'Đang giao', 'Đã giao'];
	$scope.tinhTrangHoaDon[-1] = 'Đã hủy';

	$http.post('/FlowerShop/api/get_nhan_vien', angular.toJson({
		idNhanVien: $rootScope.idNhanVien
	}), {
		headers: {
			'content-type': 'application/json;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.nhanVien = response.data;
		if (!$scope.nhanVien) {
			$scope.loginRequire = true;
		}
	}, function(error) {
		console.log(error);
	});

	$scope.intiateHoaDon = function(hoaDon) {
		hoaDon.ngayLapDate = new Date(hoaDon.ngayLap);
	}

	$scope.getGiaKhuyenMai = function(kieuSanPham, hoaDon) {
		var dsKhuyenMai = $filter('filter')(kieuSanPham.danhSachKhuyenMai, function(khuyenMai) {
			return (!khuyenMai.daXoa && hoaDon.ngayLap > khuyenMai.thoiGianBatDau && hoaDon.ngayLap < khuyenMai.thoiGianKetThuc)
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

	$scope.tongTien = function(hoaDon) {
		var sum = 0;
		hoaDon.danhSachDonHang.forEach(function(value) {
			sum = sum + ($scope.getGiaKhuyenMai(value.kieuSanPham, hoaDon) * value.soLuong);
		});
		return sum;
	}

	$scope.xemThongTinHoaDon = function(hoaDon) {
		$cookies.put('hoa_don_id', hoaDon.id, {
			path: '/FlowerShop'
		});
		$location.path('/chi_tiet_don_mua');
	}
});