app.controller('GioHangController', function($http, $scope, $rootScope, $mdToast, $mdDialog, $location, $cookies, $filter) {
	var gioHangCookie = $cookies.get('gio_hang_cookie');

	if (gioHangCookie == undefined || !gioHangCookie) {
		var listGioHang = [];
	} else {
		var listGioHang = angular.fromJson(gioHangCookie);
	}

	$http.post('/FlowerShop/api/get_danh_sach_gio_hang', angular.toJson(listGioHang), {
		headers: {
			'content-type': 'application/json;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.danhSachDonHang = response.data;
	}, function(error) {
		console.log(error);
	});

	$scope.capNhatSoLuongDonHang = function(item) {
		var objectInlist = $filter('filter')(listGioHang, {idSanPham: item.kieuSanPham.id})[0];

		if (objectInlist != undefined) {
			var index = listGioHang.indexOf(objectInlist);
			objectInlist.soLuong = item.soLuong;
			listGioHang[index] = objectInlist;
		}

		console.log(listGioHang);

		$cookies.put('gio_hang_cookie', angular.toJson(listGioHang), {
			path: '/FlowerShop'
		});
	}

	$scope.xoaDonHang = function(item) {
		var confirm = $mdDialog.confirm()
			.title('Xóa giỏ hàng')
			.textContent('Bạn có chắc chắn muốn xóa đơn hàng này trong giỏ hàng?')
			.ok('Chắc chắn')
			.cancel('Không');

		$mdDialog.show(confirm).then(function() {
			var index = $scope.danhSachDonHang.indexOf(item);
			$scope.danhSachDonHang.splice(index, 1);

			var objectInlist = $filter('filter')(listGioHang, {idSanPham: item.kieuSanPham.id})[0];

			if (objectInlist != undefined) {
				var indexList = listGioHang.indexOf(objectInlist);
				listGioHang.splice(indexList, 1);
			}

			$rootScope.soLuongSanPhamTrongGioHang = listGioHang.length;

			$cookies.put('gio_hang_cookie', angular.toJson(listGioHang), {
				path: '/FlowerShop'
			});
		}, function() {
			
		});
	}

	$scope.thanhToanGioHang = function() {
		$location.path('/hoa_don');
	}

	$scope.khuyenMaiHienTai = function(khuyenMai) {
		var current = new Date().getTime();
		return (!khuyenMai.daXoa && current > khuyenMai.thoiGianBatDau && current < khuyenMai.thoiGianKetThuc)
	}

	$scope.getGiaKhuyenMai = function(kieuSanPham) {
		var dsKhuyenMai = $filter('filter')(kieuSanPham.danhSachKhuyenMai, $scope.khuyenMaiHienTai);
		var giaKhuyenMai = kieuSanPham.giaTien;
		dsKhuyenMai.forEach(function(value) {
			var phanTramGiam = value.phanTramGiam / 100;
			var giaTienSauKhiGiamToiDa = giaKhuyenMai - value.giaGiamToiDa;
			giaKhuyenMai = giaKhuyenMai * (1 - phanTramGiam);
			if (giaKhuyenMai < giaTienSauKhiGiamToiDa) giaKhuyenMai = giaTienSauKhiGiamToiDa;
		});
		return giaKhuyenMai;
	}

	$scope.tongTien = function() {
		var sum = 0;
		$scope.danhSachDonHang.forEach(function(value) {
			sum = sum + ($scope.getGiaKhuyenMai(value.kieuSanPham) * value.soLuong);
		});
		return sum;
	}
});